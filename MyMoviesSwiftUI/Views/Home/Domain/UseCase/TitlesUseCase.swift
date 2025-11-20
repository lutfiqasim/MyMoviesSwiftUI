//
//  TitlesUseCase.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

protocol TitlesUseCaseProtocol {
    func fetchTitles<T: Decodable & Sendable>(media: Media, type: TitleListEndpoint.FetchType) async throws -> T
}

final class TitlesUseCase: TitlesUseCaseProtocol {
    
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchTitles<T>(media: Media, type: TitleListEndpoint.FetchType) async throws -> T where T : Decodable, T : Sendable {
        let endPoint = TitleListEndpoint(fetchType: type, media: media)
        
        return try await repository.call(endpoint: endPoint)
    }
}
