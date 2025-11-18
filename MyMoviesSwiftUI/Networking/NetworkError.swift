//
//  NetworkError.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underLyingError: Error)
    case missingConfig
    case urlFailed
    case decodingError(underLyingError: Error)
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underLyingError: let error):
            return "Bad URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing configuration"
        case .urlFailed:
            return "URL Parsing Failed"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        }
    }
}
