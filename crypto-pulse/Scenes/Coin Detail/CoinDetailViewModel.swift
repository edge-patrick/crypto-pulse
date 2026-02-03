//
//  CoinDetailViewModel.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class CoinDetailViewModel {
    private(set) var state: ViewState<CoinDetail> = .idle

    private let service: CoinServiceProtocol
    private let coinId: String

    init(coinId: String, service: CoinServiceProtocol? = nil) {
        self.service = service ?? AppDependencies.services.coinService
        self.coinId = coinId
    }

    func load() async {
        if case .loading = state { return }
        state = .loading

        do {
            let detail = try await service.fetchCoinDetail(id: coinId)
            state = .loaded(detail)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
