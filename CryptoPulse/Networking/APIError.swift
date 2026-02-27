//
//  APIError.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .statusCode(let code):
            return "Server error (\(code))."
        case .decoding:
            return "Failed to decode server response."
        }
    }
}
