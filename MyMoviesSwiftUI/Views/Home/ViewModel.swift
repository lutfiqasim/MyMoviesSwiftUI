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
class ViewModel {
    /// loading state
    private(set) var loadingState: LoadingState<HomeData> = .idle
    
    private let dataFetcher = DataFetcher()
    private var isFetching = false
    
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
    
}
