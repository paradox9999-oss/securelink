//
//  SplashViewModel.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit
import Swinject

class SplashInput {
    var resolver: Resolver
    var didLoad: Completion?
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

class SplashViewModel {
    
    private var input: SplashInput
    private var storageService: StorageService
    private var storeService: StoreService
    private var apiService: APINetworkService
    
    init(input: SplashInput) {
        self.input = input
        self.storageService = input.resolver.resolve(StorageService.self)!
        self.storeService = input.resolver.resolve(StoreService.self)!
        self.apiService = input.resolver.resolve(APINetworkService.self)!
    }
    
    func viewDidLoad() {
        Task {
            do {
                async let servers = try await self.apiService.application.servers()
                try await self.storeService.loadProducts()
                self.storageService.servers = try await servers
                await MainActor.run {
                    self.input.didLoad?()
                }
            } catch (let error) {
                await MainActor.run {
                    self.input.didLoad?()
                }
                print(error)
            }
        }
        
    }
    
    func progressDidLoad() {
//        self.input.didLoad?()
    }
    
}
