//
//  ViewModel.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation
import OSLog

@MainActor
@Observable
final class ViewModel {
    /// loading state
    private(set) var loadingState: LoadingState<HomeData> = .idle

    private let titlesUseCase: TitlesUseCaseProtocol
    private var isFetching = false

    init(titlesUseCase: TitlesUseCaseProtocol) {
        self.titlesUseCase = titlesUseCase
    }

    static func makeDefault() -> ViewModel {
        ViewModel(titlesUseCase: DIContainer.shared.titlesUseCase)
    }
    
    func getTitles(forceRefresh: Bool = false) async {
        
        if isFetching { return }
        
        if !forceRefresh {
            if case .success = loadingState { return }
        }
        
        loadingState = .loading
        isFetching = true
        
        do {
            async let tMovies: TitlesApiResponse =
                titlesUseCase.fetchTitles(media: .movie, type: .trending)

            async let tTV: TitlesApiResponse =
                titlesUseCase.fetchTitles(media: .tv, type: .trending)

            async let trMovies: TitlesApiResponse =
                titlesUseCase.fetchTitles(media: .movie, type: .topRated)

            async let trTV: TitlesApiResponse =
                titlesUseCase.fetchTitles(media: .tv, type: .topRated)

            let result = HomeData(
                trendingMovies: try await tMovies.results,
                trendingTV: try await tTV.results,
                topRatedMovies: try await trMovies.results,
                topRatedTV: try await trTV.results
            )

            loadingState = .success(result)
        } catch {
            loadingState = .failed(underlyingError: error)
        }
        isFetching = false
    }
    
}


/*
 
 func getTitles(forceRefresh: Bool = false) async {
 if isFetching {return}
 if !forceRefresh {
 if case .success = loadingState {return}
 }
 
 loadingState = .loading
 isFetching = true
 do {
 //            trendingMovies = try await dataFetcher.fetchTitles(for: .movie, by: .trending)
 //            trendingTV = try await dataFetcher.fetchTitles(for: .tv, by: .trending)
 //
 //            topRatedMovies = try await dataFetcher.fetchTitles(for: .movie, by: .topRated)
 //            topRatedTV = try await dataFetcher.fetchTitles(for: .tv, by: .topRated)
 async let tMovies = dataFetcher.fetchTitles(for: .movie, by: .trending)
 async let tTV = dataFetcher.fetchTitles(for: .tv, by: .trending)
 async let trMovies = dataFetcher.fetchTitles(for: .movie, by: .topRated)
 async let trTV = dataFetcher.fetchTitles(for: .tv, by: .topRated)
 
 let result = HomeData(trendingMovies: try await tMovies,
 trendingTV: try await tTV,
 topRatedMovies: try await trMovies,
 topRatedTV: try await trTV)
 loadingState = .success(result)
 } catch {
 Logger.d(error.localizedDescription)
 loadingState = .failed(underlyingError: error)
 }
 
 isFetching = false
 }
 */

