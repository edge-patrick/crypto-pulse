//
//  ProfileView.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel
    
    init() {
        _viewModel = State(wrappedValue: ProfileViewModel())
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Profile")
        }
        .task {
            await viewModel.load()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading profile...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let user):
            ScrollView {
                VStack(spacing: 24) {
                    profileHeader(user)
                    contactSection(user)
                    companySection(user)
                    addressSection(user)
                }
                .padding()
            }
        case .failed(let message):
            VStack(spacing: 12) {
                Text("Couldn't load profile")
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
    
    private func profileHeader(_ user: User) -> some View {
        VStack(spacing: 12) {
            Circle()
                .fill(Color.blue.gradient)
                .frame(width: 100, height: 100)
                .overlay {
                    Text(user.name.prefix(2).uppercased())
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white)
                }
            
            Text(user.name)
                .font(.title2.bold())
            
            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    
    private func contactSection(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Contact")
                .font(.headline)
            
            InfoRow(icon: "envelope.fill", title: "Email", value: user.email)
            InfoRow(icon: "phone.fill", title: "Phone", value: user.phone)
            InfoRow(icon: "globe", title: "Website", value: user.website)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func companySection(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Company")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.company.name)
                    .font(.body.bold())
                Text(user.company.catchPhrase)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func addressSection(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Address")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(user.address.street), \(user.address.suite)")
                Text("\(user.address.city) \(user.address.zipcode)")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ProfileView()
}
