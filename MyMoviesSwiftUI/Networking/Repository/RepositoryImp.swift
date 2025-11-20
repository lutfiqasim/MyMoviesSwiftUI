//
//  RepositoryImp.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 20/11/2025.
//

import Foundation

struct Repository: RepositoryProtocol {
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func call<T: Decodable & Sendable>(endpoint: Endpoint) async throws -> T {
        try await client.fetch(endpoint, as: T.self)
    }
}
