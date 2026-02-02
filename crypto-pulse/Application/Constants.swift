//
//  Constants.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

struct Constants {
    
    struct API {
        
        struct CoinGecko {
            #if DEBUG
            static let key = "" // Your API key here
            static let baseURL = "https://api.coingecko.com/api/v3"
            #else
            static let key = "prod-key"
            static let baseURL = "prod-url"
            #endif
        }
        
        struct JSONPlaceholder {
            #if DEBUG
            static let baseURL = "https://jsonplaceholder.typicode.com"
            #else
            static let baseURL = "prod-url"
            #endif
        }
        
    }
    
}
