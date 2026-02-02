//
//  CoinRouter.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

enum CoinRouter {
    case topCoins
    case coinDetail(id: String)

    var endpoint: Endpoint {
        Endpoint(path: path, method: method, queryItems: queryItems)
    }

    private var method: HTTPMethod {
        switch self {
        case .topCoins, .coinDetail:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .topCoins:
            return "/coins/markets"
        case .coinDetail(let id):
            return "/coins/\(id)"
        }
    }

    private var queryItems: [URLQueryItem] {
        switch self {
        case .topCoins:
            return [
                URLQueryItem(name: "vs_currency", value: "usd"),
                URLQueryItem(name: "order", value: "market_cap_desc"),
                URLQueryItem(name: "per_page", value: "20"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "sparkline", value: "false"),
                URLQueryItem(name: "price_change_percentage", value: "24h")
            ]
        case .coinDetail:
            return [
                URLQueryItem(name: "localization", value: "false"),
                URLQueryItem(name: "tickers", value: "false"),
                URLQueryItem(name: "market_data", value: "true"),
                URLQueryItem(name: "community_data", value: "false"),
                URLQueryItem(name: "developer_data", value: "false"),
                URLQueryItem(name: "sparkline", value: "false")
            ]
        }
    }
}
