//
//  ViewState.swift
//  crypto-pulse
//
//  Created by Patrick Edge on 27/01/2026.
//

enum ViewState<Value: Equatable>: Equatable {
    case idle
    case loading
    case loaded(Value)
    case failed(String)
}
