//
//  Constants.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation

typealias Completion = () -> Void

struct Constants {
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case acceptLanguage = "accept-language"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
    
    struct URLs {
        static let privacy: String = "https://docs.google.com/document/d/1fJlqtcymw6fFFo1HO4Lp6XemSX97NCOtZh1qhggnfSs/edit?usp=sharing"
        static let terms: String = "https://docs.google.com/document/d/1y-4_0X6AO62MN-beLmDy_1VyBmstxmR_duFxz-lX7Rs/edit?usp=sharing"
        static let support: String = "kay@synaxisdata.space"
    }
    
    struct Subscriptions {
        static let weekly = "com.aesthetics.securelink.week"
        static let monthly = "com.aesthetics.securelink.month"
    }
    
    
}
