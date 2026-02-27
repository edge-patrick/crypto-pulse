//
//  UserService.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUserProfile(id: Int) async throws -> User
}

struct UserService: UserServiceProtocol {
    private let apiClient: APIServiceProtocol

    init(apiClient: APIServiceProtocol) {
        self.apiClient = apiClient
    }

    func fetchUserProfile(id: Int) async throws -> User {
        try await apiClient.request(UserRouter.userProfile(id: id).endpoint)
    }
}
