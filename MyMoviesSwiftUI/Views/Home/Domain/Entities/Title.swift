//
//  Title.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 17/11/2025.
//

import Foundation

struct Title: Decodable, Identifiable, Sendable {
    var id: Int
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    var posterURLString: String? {
        guard let path = posterPath else { return nil }
        return Constants.posterURLString + path
    }
    
    static var previewTitles = [
        Title(id: 1, title: "Steins;Gate", name: "Steins;Gate", overview: "An experimental research facility in the Japanese city of Tokai is secretly run by the enigmatic scientist Dr. Stephen Hawking.", posterPath: Constants.testTitleURL),
        Title(id: 2, title: "One Punch Man", name: "One Punch Man", overview: "Comedy fighting Anime", posterPath: Constants.testTitleURL2),
        Title(id: 2, title: "One Piece", name: "One Piece", overview: "Pirate adventure Anime", posterPath: Constants.testTitleURL3)
    ]
}
