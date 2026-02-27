//
//  CryptoPulse.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

@main
struct CryptoPulse: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.dependencies, .services)
        }
    }
}
