//
//  LoadingState.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

enum LoadingState<Value>: Equatable {
    case idle
    case loading
    case success(_ T: Value? = nil)
    case failed(underlyingError: Error)
    
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case (.success(_), .success(_)):
            return true
        case (.failed(_), .failed(_)):
            return true
        default:
            return false
        }
    }
}
