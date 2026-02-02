//
//  crypto_pulseTests.swift
//  crypto-pulseTests
//
//  Created by Patrick Edge on 27/01/2026.
//

import XCTest
@testable import crypto_pulse

final class crypto_pulseTests: XCTestCase {

    // MARK: - CoinList Tests
    
    @MainActor
    /// Verifies that the CoinsListViewModel correctly transitions to the loaded state when the service returns data successfully.
    func testCoinsListViewModel_WhenLoadSucceeds_StateIsLoaded() async {
        let coin = CoinMarket.mock()
        let service = MockCoinService(coins: [coin])
        let viewModel = CoinsListViewModel(service: service)
        
        await viewModel.load()
        
        XCTAssertEqual(viewModel.state, .loaded([coin]))
    }
    
    @MainActor
    /// Ensures that the CoinsListViewModel handles service errors by transitioning to the failed state with the correct error message.
    func testCoinsListViewModel_WhenLoadFails_StateIsFailed() async {
        let service = MockCoinService(error: TestError.sample)
        let viewModel = CoinsListViewModel(service: service)
        
        await viewModel.load()
        
        XCTAssertEqual(viewModel.state, .failed(TestError.sample.localizedDescription))
    }
    
    // MARK: - CoinDetail Tests
    
    @MainActor
    /// Validates that the CoinDetailViewModel successfully loads and stores the detailed information for a specific coin.
    func testCoinDetailViewModel_WhenLoadSucceeds_StateIsLoaded() async {
        let detail = CoinDetail.mock()
        let service = MockCoinService(detail: detail)
        let viewModel = CoinDetailViewModel(coinId: "bitcoin", service: service)
        
        await viewModel.load()
        
        XCTAssertEqual(viewModel.state, .loaded(detail))
    }
    
    // MARK: - Profile Tests
    
    @MainActor
    /// Checks that the ProfileViewModel correctly fetches and displays the user profile data upon a successful service call.
    func testProfileViewModel_WhenLoadSucceeds_StateIsLoaded() async {
        let user = User.mock()
        let service = MockUserService(user: user)
        let viewModel = ProfileViewModel(userId: 1, service: service)
        
        await viewModel.load()
        
        XCTAssertEqual(viewModel.state, .loaded(user))
    }
}

// MARK: - Mocks

private enum TestError: LocalizedError {
    case sample
    var errorDescription: String? { "Sample error message" }
}

private struct MockCoinService: CoinServiceProtocol {
    var coins: [CoinMarket] = []
    var detail: CoinDetail? = nil
    var error: Error? = nil

    func fetchTopCoins() async throws -> [CoinMarket] {
        if let error { throw error }
        return coins
    }

    func fetchCoinDetail(id: String) async throws -> CoinDetail {
        if let error { throw error }
        guard let detail else { throw TestError.sample }
        return detail
    }
}

private struct MockUserService: UserServiceProtocol {
    var user: User? = nil
    var error: Error? = nil
    
    func fetchUserProfile(id: Int) async throws -> User {
        if let error { throw error }
        guard let user else { throw TestError.sample }
        return user
    }
}

// MARK: - Mock Data Extensions

extension CoinMarket {
    static func mock() -> CoinMarket {
        CoinMarket(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: nil,
            currentPrice: 50000,
            marketCap: 1000000,
            marketCapRank: 1,
            priceChangePercentage24h: 2.5
        )
    }
}

extension CoinDetail {
    static func mock() -> CoinDetail {
        CoinDetail(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            description: .init(en: "Digital Gold"),
            image: .init(large: nil),
            marketData: .init(
                currentPrice: ["usd": 50000],
                marketCap: ["usd": 1000000],
                priceChangePercentage24h: 2.5
            )
        )
    }
}

extension User {
    static func mock() -> User {
        User(
            id: 1,
            name: "Test User",
            username: "testuser",
            email: "test@example.com",
            phone: "123-456",
            website: "example.com",
            company: .init(name: "Test Co", catchPhrase: "Testing", bs: "test"),
            address: .init(street: "Main St", suite: "101", city: "Test City", zipcode: "12345")
        )
    }
}
