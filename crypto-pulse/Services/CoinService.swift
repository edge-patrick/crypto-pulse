//
//  CoinService.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchTopCoins() async throws -> [CoinMarket]
    func fetchCoinDetail(id: String) async throws -> CoinDetail
}

struct CoinService: CoinServiceProtocol {
    private let apiClient: APIServiceProtocol

    init(apiClient: APIServiceProtocol) {
        self.apiClient = apiClient
    }

    func fetchTopCoins() async throws -> [CoinMarket] {
        return try await apiClient.request(CoinRouter.topCoins.endpoint)
    }

    func fetchCoinDetail(id: String) async throws -> CoinDetail {
        return try await apiClient.request(CoinRouter.coinDetail(id: id).endpoint)
    }
}
