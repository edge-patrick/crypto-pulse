//
//  AppDependencies.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

struct AppDependencies {
    let coinService: CoinServiceProtocol
    let userService: UserServiceProtocol

    static let services = AppDependencies(
        coinService: CoinService(
            apiClient: APIService(
                baseURL: Constants.API.CoinGecko.baseURL,
                headers: ["x-cg-demo-api-key": Constants.API.CoinGecko.key]
            )
        ),
        userService: UserService(
            apiClient: APIService(
                baseURL: Constants.API.JSONPlaceholder.baseURL
            )
        )
    )
}
