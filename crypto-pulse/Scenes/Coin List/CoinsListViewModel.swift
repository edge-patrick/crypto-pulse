//
//  CoinsListViewModel.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class CoinsListViewModel {
    
    private(set) var state: ViewState<[CoinMarket]> = .idle

    private let service: CoinServiceProtocol

    init(service: CoinServiceProtocol? = nil) {
        self.service = service ?? AppDependencies.services.coinService
    }

    func load() async {
        if case .loading = state { return }
        state = .loading

        do {
            let coins = try await service.fetchTopCoins()
            state = .loaded(coins)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
