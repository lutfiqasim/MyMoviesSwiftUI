# MyMoviesSwiftUI

A SwiftUI app built to explore and learn modern iOS development practices while integrating with The Movie Database (TMDB) API v3. The project focuses on Clean Architecture, clear in-app data flow, Swift Concurrency (async/await), and a range of modern SwiftUI capabilities.

## Purpose
This project was created for learning and experimentation. It is not intended for production use. The primary goals were to:
- Practice Clean Architecture with clear separation of Presentation, Domain (Use Cases), and Data (Repository/Data Sources).
- Use Swift Concurrency (async/await) end-to-end.
- Explore modern SwiftUI patterns and fetures.


## Architecture Overview
The app follows a layered, feature-first structure inspired by Clean Architecture:
- Presentation (SwiftUI Views & ViewModels)
- Domain (UseCases, Entities, Protocols)
- Data (Repositories, Data Sources, Endpoints)
- Networking (shared HTTP client / request & response handling)

Example Domain snippet:
```swift
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
```

## Author
  - **Lutfi Qasim**  
    Built for learning purposes: TMDB v3, Clean Architecture, SwiftUI, async/await, and modern SwiftUI features.
