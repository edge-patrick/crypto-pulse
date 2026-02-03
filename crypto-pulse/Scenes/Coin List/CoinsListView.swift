//
//  CoinsListView.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

struct CoinsListView: View {
    
    @State private var viewModel: CoinsListViewModel

    init() {
        _viewModel = State(wrappedValue: CoinsListViewModel())
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Top Coins")
        }
        .task {
            await viewModel.load()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading coins...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let coins):
            List(coins) { coin in
                NavigationLink {
                    CoinDetailView(coinId: coin.id)
                } label: {
                    CoinRowView(coin: coin)
                }
            }
            .listStyle(.plain)
        case .failed(let message):
            VStack(spacing: 12) {
                Text("Couldn't load coins")
                    .font(.headline)
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Button("Try Again") {
                    Task { await viewModel.load() }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private struct CoinRowView: View {
    let coin: CoinMarket

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: coin.image) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "bitcoinsign.circle")
                                .foregroundStyle(.secondary)
                        }
                }
            }
            .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.headline)
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(coin.currentPrice, format: .currency(code: "USD"))
                    .font(.headline)
                if let change = coin.priceChangePercentage24h {
                    Text(change / 100, format: .percent.precision(.fractionLength(2)))
                        .font(.caption)
                        .foregroundStyle(change >= 0 ? .green : .red)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    CoinsListView()
}
