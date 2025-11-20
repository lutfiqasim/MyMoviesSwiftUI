//
//  DIContainer.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 20/11/2025.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    var titlesUseCase: TitlesUseCaseProtocol {
        TitlesUseCase(repository: Repository(client: APIClient()))
    }
}
