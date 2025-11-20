//
//  TitleAPIResponse.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 20/11/2025.
//

import Foundation
nonisolated
struct TitlesApiResponse: Decodable, Sendable {
    var results: [Title] = []
}
