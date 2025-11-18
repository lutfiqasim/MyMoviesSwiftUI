//
//  DataFetcher.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 17/11/2025.
//

import Foundation
import OSLog

struct DataFetcher {
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    
    //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY
    
    func fetchTitles(for media: Media, by type: TitleFetchType) async throws -> [Title] {
        let fetchTitlesURL = try buildURL(media: media, type: type)
        guard let fetchTitlesURL else {
            throw NetworkError.urlFailed
        }
        
        Logger.d(fetchTitlesURL.absoluteString)
        
        let (data, urlRespose) = try await URLSession.shared.data(from: fetchTitlesURL)
        
        guard let response = urlRespose as? HTTPURLResponse, response.statusCode == 200
        else {
            throw NetworkError.badURLResponse(underLyingError: NSError(domain: "DataFetcher", code: (urlRespose as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Http response"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            var titles = try decoder.decode(APIObject.self, from: data).results
            Constants.addPosterPath(to: &titles)
            return titles
        } catch let error as DecodingError {
            throw NetworkError.decodingError(underLyingError: error)
        }
    }
    
    private func buildURL(media: Media, type: TitleFetchType) throws -> URL?{
        guard let baseURL = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        let path = type.path(for: media.rawValue)
        
        guard let url = URL(string: baseURL)?.appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else { throw NetworkError.urlFailed}
        
        return url
    }
}
