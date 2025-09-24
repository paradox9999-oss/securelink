//
//  Setting.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit

enum Setting: CaseIterable {
    case faceId
    case changePasscode
    
    case contactUs
    
    case privacyPolicy
    case termsOfUse
    
    var icon: UIImage? {
        switch self {
        case .faceId:
            return Asset.settingsFaceId.image
        case .changePasscode:
            return Asset.settingsChangePasscode.image
        case .contactUs:
            return Asset.settingsContact.image
        case .privacyPolicy:
            return Asset.settingsPolicy.image
        case .termsOfUse:
            return Asset.settingTerms.image
        }
    }
    
    var title: String {
        switch self {
        case .faceId:
            return "Face ID"
        case .changePasscode:
            return "Change pasccode"
        case .contactUs:
            return "Contact Us"
        case .privacyPolicy:
            return "Privacy Policy"
        case .termsOfUse:
            return "Terms of use"
        }
    }
    
    var color: UIColor {
        switch self {
        case .faceId:
            return Asset.mainGrey.color
        case .changePasscode:
            return Asset.mainGrey.color
        case .contactUs:
            return Asset.mainGrey.color
        case .privacyPolicy:
            return Asset.mainGrey.color
        case .termsOfUse:
            return Asset.mainGrey.color
        }
    }
}

struct SettingGroup {
    var items: [Setting]
    var title: String
}
