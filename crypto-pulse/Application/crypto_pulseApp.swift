//
//  crypto_pulseApp.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

@main
struct crypto_pulseApp: App {
    private let dependencies = AppDependencies.services

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
