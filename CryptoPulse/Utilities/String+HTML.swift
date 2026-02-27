//
//  String+HTML.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

import Foundation

extension String {
    var strippedHTML: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
