//
//  ServersViewModel.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import Swinject

class ServersInput {
    
    var didSelect: ((String) -> Void)?
    var resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
}

class ServersViewModel: ObservableObject {
    
    var input: ServersInput
    
    var servers: [ServerCountry]
    var storageService: StorageService
    var selectServer: String?
    
    init(input: ServersInput) {
        self.input = input
        self.storageService = input.resolver.resolve(StorageService.self)!
        self.servers = self.storageService.servers
        self.selectServer = self.storageService.currentServerID
    }
    
    func didSelectServer(id: String) {
        self.selectServer = id
        self.input.didSelect?(id)
    }
    
}
