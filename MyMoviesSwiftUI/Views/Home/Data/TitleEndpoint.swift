//
//  TitleFetchType.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

struct TitleListEndpoint: Endpoint {
    
    enum FetchType: String {
        case trending
        case topRated = "top_rated"
    }
    
    let fetchType: FetchType
    let media: Media
    
    var method: HTTPMethod {
        switch self.fetchType {
        case .trending, .topRated:
            return .get
        }
    }
    
    var path: String {
        switch fetchType {
        case .trending:
            return "3/trending/\(media.rawValue)/day"
        case .topRated:
            return "3/\(media.rawValue)/top_rated"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "api_key", value: APIConfig.shared?.tmdbAPIKey)]
    }
}

