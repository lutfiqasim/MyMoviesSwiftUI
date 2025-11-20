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
    case invalidURL
    case decodingError(underLyingError: Error)
    case unknown
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underLyingError: let error):
            return "Bad URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing configuration"
        case .invalidURL:
            return "URL Parsing Failed"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .unknown:
            return "Something Went Wrong"
        }
    }
}
