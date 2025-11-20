//
//  RepositoryProtocol.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 20/11/2025.
//

import Foundation

protocol RepositoryProtocol{
    func call<T: Decodable & Sendable>(endpoint: Endpoint) async throws -> T
}
