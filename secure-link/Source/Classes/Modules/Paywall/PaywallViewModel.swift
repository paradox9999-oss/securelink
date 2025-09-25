//
//  PaywallViewModel.swift
//  secure-link
//
//  Created by Александр on 04.07.2025.
//

import Foundation
import Swinject
import UIKit

class PaywallInput {
    var resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
}

class PaywallViewModel {
    
    enum PatwallButtonTap {
        case terms
        case privacy
        case restore
    }
    
    var didDismiss: Completion?
    var didLoading: ((Bool) -> Void)?
    var didShowError: ((String) -> Void)?
    
    private var input: PaywallInput
    private var storeService: StoreService
    var dipslayProducts: [ProductDTO] {
        let p = [ProductDTO(id: "1", name: "Weekly $9.99 | first 3 days free", price: "", description: ""),
                 ProductDTO(id: "2", name: "Subscribe $24.99 | Monthly", price: "", description: "")]
        return p
//        return self.storeService.displayProducts
    }
    
    init(input: PaywallInput) {
        self.input = input
        self.storeService = input.resolver.resolve(StoreService.self)!
    }
    
    func viewDidLoad() {
        self.storeService.didUpdate = { [weak self] in
            if self?.storeService.hasUnlockedPro == true {
                self?.didDismiss?()
            }
        }
    }
    
    func didTap(state: PatwallButtonTap) {
        switch state {
            case .restore:
                self.storeService.restore { errorString in
                    //
                }
            case .privacy:
                UIApplication.shared.open(URL(string: Constants.URLs.privacy)!)
            case .terms:
                UIApplication.shared.open(URL(string: Constants.URLs.terms)!)
        }
    }
    
    func payTapped(productId: String) {
        self.didLoading?(true)
        self.storeService.pay(
            productId: productId,
            completion: { [weak self] errorString in
                
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.didLoading?(false)
                    if let errorString = errorString {
                        self.didShowError?(errorString)
                    } else {
                        Task {
                            do {
//                                    let _ = try await self.apiService.application.notify(acc: self.storageService.accToken, paywall: "origin")
                            }
                        }
                    }
                }
            }
        )
    }
    
    func restore() {
        self.storeService.restore { errorString in
            DispatchQueue.main.async {
                if let errorString = errorString {
                    self.didShowError?(errorString)
                } else {
                    self.didShowError?("Restore success")
                }
            }
        }
    }
    
}
