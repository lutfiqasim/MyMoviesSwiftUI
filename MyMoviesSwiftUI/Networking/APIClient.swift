//
//  APIClient.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable & Sendable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}

final class APIClient: APIClientProtocol {
    
    private let decoder: JSONDecoder
    private let session: URLSession
    
    static let shared = APIClient(session: .shared, decoder: JSONDecoder())
    
    init(session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetch<T: Decodable & Sendable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        let request = try endpoint.makeRequest()
        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.badURLResponse(underLyingError: NSError(domain: "APIClient", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Http response"]))
            }
            
            guard 200..<300 ~= http.statusCode else { throw NetworkError.badURLResponse(underLyingError: NSError(domain: "DataFetcher", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid status code \(http.statusCode)"])) }
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(underLyingError: error)
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}
