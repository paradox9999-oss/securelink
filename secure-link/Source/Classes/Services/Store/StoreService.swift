//
//  StoreService.swift
//  secure-link
//
//  Created by Александр on 04.07.2025.
//

import Foundation
import StoreKit
import Adapty

struct ProductDTO {
    var id: String
    var name: String
    var description: String
    var localizedPrice: String
    var salePrice: String?
    var sale: Int?
    var hasIntroOffer: Bool
    
    private var product: Product?
    
    static var mock: [ProductDTO] {
        var week = ProductDTO(id: "1")
        week.description = "Weekly"
        
        var week2 = ProductDTO(id: "2")
        
        if week.description.isEmpty == false, let n = NumberFormatter().number(from: week.description) {
            let sale = CGFloat(truncating: n)
            let price = 3.99 / Decimal(sale)
            let formatter = NumberFormatter()
            formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: price as NSNumber) {
                week.salePrice = "\(formattedTipAmount)/month"
            }
        }
        
//        if let intro = product.subscription?.introductoryOffer {
            week.hasIntroOffer = true
//        } else {
//            self.hasIntroOffer = false
//        }
        
        week.localizedPrice = "$3.99"

        week.name = "Weekly" + " " + "3.88"
        
        if week.hasIntroOffer {
            week.name = week.name + " | 3 free days trial"
        }
        
        return [week, week2]
    }
    
    init(product: Product) {
        self.product = product
        self.id = product.id
        self.description = product.description
        
        if let intro = product.subscription?.introductoryOffer {
            self.hasIntroOffer = true
        } else {
            self.hasIntroOffer = false
        }
        
        self.localizedPrice = product.displayPrice
        
        self.name = product.displayName + " " + product.displayPrice
        
        if self.hasIntroOffer {
            self.name = self.name + " • 3-day trial"
        }
    }
    
    init(id: String, name: String, price: String, description: String) {
        self.id = id
        self.description = description
        self.localizedPrice = price
        self.name = name
        self.hasIntroOffer = false
    }
    
    init(id: String) {
        self.id = id
        self.description = "Monthly Subscription"
        self.localizedPrice = "99.99$"
        self.salePrice = "4.7$/month"
        self.name = "Billed Monthly "
        self.hasIntroOffer = false
    }
    
    var saleString: String? {
        if let sale = self.sale, sale > 0 {
            return "Save" + " " + "\(sale)" + "%"
        }
        
        return nil
    }
}

public enum PurchaseResult {
    case success(VerificationResult<Transaction>)
    case userCancelled
    case pending
}

enum MyError: Error {
    case userCanceled
    case unknown
}

protocol StoreService {
    
    var displayProducts: [ProductDTO] { get }
    var hasUnlockedPro: Bool { get }
    var didUpdate: Completion? { get set }
    
    func loadProducts() async throws
    func restore(completion: ((String?) -> Void)?)
    func pay(productId: String, completion: ((String?) -> Void)?)
    
}

class StoreServiceImplementation: NSObject, StoreService {

    var displayProducts: [ProductDTO] {
//        return ProductDTO.mock
        return products.map { product in
            let p = ProductDTO(
                product: product
            )
            return p
        }
    }
    private var productIds = [Constants.Subscriptions.weekly, Constants.Subscriptions.monthly]
    private var products: [Product] = []
    private var productsLoaded = false
    private var updates: Task<Void, Never>? = nil
    
    var didUpdate: Completion?

    var purchasedProductIDs = Set<String>() {
        didSet {
            self.didUpdate?()
        }
    }

    var hasUnlockedPro: Bool {
        return !self.purchasedProductIDs.isEmpty
    }
    
    override init() {
        super.init()
        self.updates = observeTransactionUpdates()
        
        Task {
            await self.updatePurchasedProducts()
        }
    }

    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        
        do {
            let product = try await Product.products(for: productIds)
            self.products = productIds.compactMap { id in
                product.first { $0.id == id }
            }
            self.productsLoaded = true
        } catch {
            debugPrint("Error: \(error)")
            throw error
        }
    }
    
    func pay(productId: String, completion: ((String?) -> Void)?) {
        guard let product = self.products.first(where: { $0.id == productId }) else {
            print("Product with ID \(productId) not found")
            completion?("Product with ID \(productId) not found")
            return
        }
        Task {
            do {
                try await self.purchase(product)
                completion?(nil)
            } catch {
                completion?(error.localizedDescription)
                print("Ошибка оплаты: \(error)")
            }
        }
    }
    
    private func purchase(_ product: Product) async throws {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verificationResult):
                let transaction = try checkVerified(verificationResult)
                await self.updatePurchasedProducts()
                await transaction.finish()
            case .userCancelled:
                debugPrint("Cancel")
                throw MyError.userCanceled
            case .pending:
                debugPrint("Waiting")
            @unknown default:
                debugPrint("Unknown")
                throw MyError.unknown
            }
        } catch {
            debugPrint("error: \(error)")
            throw error
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let transaction):
            return transaction
        case .unverified(_, let error):
            debugPrint("error check transaction: \(error)")
            throw error
        }
    }
    
    @MainActor
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }

            if transaction.revocationDate == nil {
                purchasedProductIDs.insert(transaction.productID)
            } else {
                purchasedProductIDs.remove(transaction.productID)
            }
        }
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                await self.updatePurchasedProducts()
            }
        }
    }
    
    func restore(completion: ((String?) -> Void)?) {
        Task {
            do {
                try await AppStore.sync()
                completion?(nil)
            } catch {
                completion?(error.localizedDescription)
            }
        }
    }
    
    deinit {
        updates?.cancel()
    }
    
}
