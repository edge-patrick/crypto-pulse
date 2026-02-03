//
//  HomeView.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        TabView {
            Tab("Coins", systemImage: "bitcoinsign.circle.fill") {
                CoinsListView()
            }
            
            Tab("Profile", systemImage: "person.fill") {
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeView()
}
