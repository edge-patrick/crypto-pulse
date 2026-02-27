//
//  CoinDetail.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

struct CoinDetail: Identifiable, Decodable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
    let image: ImageInfo
    let marketData: MarketData

    var currentPriceUSD: Double? {
        marketData.currentPrice["usd"]
    }

    var marketCapUSD: Double? {
        marketData.marketCap["usd"]
    }

    var priceChangePercentage24h: Double? {
        marketData.priceChangePercentage24h
    }

    var descriptionText: String? {
        description.en?
            .strippedHTML
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension CoinDetail {
    struct Description: Decodable, Hashable {
        let en: String?
    }

    struct ImageInfo: Decodable, Hashable {
        let large: URL?
    }

    struct MarketData: Decodable, Hashable {
        let currentPrice: [String: Double]
        let marketCap: [String: Double]
        let priceChangePercentage24h: Double?
    }
}
