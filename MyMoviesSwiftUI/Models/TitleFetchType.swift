//
//  TitleFetchType.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

enum TitleFetchType: String {
    case trending
    case topRated = "top_rated"
}

extension TitleFetchType {
    func path(for media: String) -> String {
        switch self {
        case .trending:
            return "3/trending/\(media)/day"
        case .topRated:
            return "3/\(media)/top_rated"
        }
    }
}
