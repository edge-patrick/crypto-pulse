//
//  CoinDetailView.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

struct CoinDetailView: View {
    @State private var viewModel: CoinDetailViewModel

    init(coinId: String) {
        _viewModel = State(wrappedValue: CoinDetailViewModel(coinId: coinId))
    }

    var body: some View {
        content
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading details...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let detail):
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header(detail)
                    priceSection(detail)
                    descriptionSection(detail)
                }
                .padding()
            }
        case .failed(let message):
            VStack(spacing: 12) {
                Text("Couldn't load details")
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

    private func header(_ detail: CoinDetail) -> some View {
        HStack(spacing: 12) {
            AsyncImage(url: detail.image.large) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "bitcoinsign.circle")
                                .foregroundStyle(.secondary)
                        }
                }
            }
            .frame(width: 54, height: 54)

            VStack(alignment: .leading, spacing: 4) {
                Text(detail.name)
                    .font(.title2.bold())
                Text(detail.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    private func priceSection(_ detail: CoinDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Market")
                .font(.headline)

            CoinInfoRow(
                title: "Price",
                value: detail.currentPriceUSD,
                format: { value in
                    value.formatted(.currency(code: "USD"))
                }
            )
            CoinInfoRow(
                title: "Market Cap",
                value: detail.marketCapUSD,
                format: { value in
                    value.formatted(.number.notation(.compactName))
                }
            )
            if let change = detail.priceChangePercentage24h {
                HStack {
                    Text("24h Change")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(change / 100, format: .percent.precision(.fractionLength(2)))
                        .foregroundStyle(change >= 0 ? .green : .red)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func descriptionSection(_ detail: CoinDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About")
                .font(.headline)
            Text(detail.descriptionText?.isEmpty == false ? detail.descriptionText! : "No description available.")
                .foregroundStyle(.secondary)
        }
    }
}

private struct CoinInfoRow: View {
    let title: String
    let value: Double?
    let format: (Double) -> String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            if let value {
                Text(format(value))
                    .fontWeight(.semibold)
            } else {
                Text("—")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

