//
//  HomeView.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dependencies) private var dependencies

    var body: some View {
        TabView {
            Tab("Coins", systemImage: "bitcoinsign.circle.fill") {
                CoinsListView(service: dependencies.coinService)
            }
            
            Tab("Profile", systemImage: "person.fill") {
                ProfileView(service: dependencies.userService)
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(\.dependencies, .services)
}
