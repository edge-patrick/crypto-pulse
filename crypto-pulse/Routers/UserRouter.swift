//
//  UserRouter.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

enum UserRouter {
    case userProfile(id: Int)
    
    var endpoint: Endpoint {
        Endpoint(path: path, method: method, queryItems: queryItems)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .userProfile:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .userProfile(let id):
            return "/users/\(id)"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .userProfile:
            return []
        }
    }
}
