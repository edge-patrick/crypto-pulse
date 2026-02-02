//
//  User.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

struct User: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let company: Company
    let address: Address
    
    struct Company: Decodable, Hashable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
    
    struct Address: Decodable, Hashable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
    }
}
