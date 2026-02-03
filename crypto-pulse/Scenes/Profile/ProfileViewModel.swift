//
//  ProfileViewModel.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class ProfileViewModel {
    private(set) var state: ViewState<User> = .idle
    
    private let service: UserServiceProtocol
    private let userId: Int
    
    init(userId: Int = 1, service: UserServiceProtocol? = nil) {
        self.userId = userId
        self.service = service ?? AppDependencies.services.userService
    }
    
    func load() async {
        if case .loading = state { return }
        state = .loading
        
        do {
            let user = try await service.fetchUserProfile(id: userId)
            state = .loaded(user)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
