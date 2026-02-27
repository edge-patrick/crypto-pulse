//
//  CoinMarket.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

struct CoinMarket: Identifiable, Decodable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let image: URL?
    let currentPrice: Double
    let marketCap: Double?
    let marketCapRank: Int?
    let priceChangePercentage24h: Double?
}
