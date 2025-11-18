//
//  Errors.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 17/11/2025.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underLyingError: Error)
    case decodingError(underLyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .dataLoadingFailed(underLyingError: let error):
            return "Data loading failed: \(error.localizedDescription)"
        case .decodingError(underLyingError: let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}
