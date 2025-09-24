//
//  PaywallViewModel.swift
//  secure-link
//
//  Created by Александр on 04.07.2025.
//

import Foundation
import Swinject

class PaywallInput {
    var resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
}

class PaywallViewModel {
    
    private var input: PaywallInput
    
    init(input: PaywallInput) {
        self.input = input
    }
    
}
