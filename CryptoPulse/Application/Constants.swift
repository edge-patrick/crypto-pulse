//
//  Constants.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

enum Constants {
    enum API {
        enum CoinGecko {
            static var key: String {
                guard let value = (Bundle.main.infoDictionary?["API_KEY"] as? String)?
                    .replacingOccurrences(of: "\\", with: "") else {
                    return ""
                }
                return value
            }

            static var baseURL: String {
                #if DEBUG
                "https://api.coingecko.com/api/v3"
                #else
                "prod-url"
                #endif
            }
        }

        enum JSONPlaceholder {
            static var baseURL: String {
                #if DEBUG
                "https://jsonplaceholder.typicode.com"
                #else
                "prod-url"
                #endif
            }
        }
    }
}
