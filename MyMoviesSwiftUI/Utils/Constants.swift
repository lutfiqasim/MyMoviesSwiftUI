//
//  Constants.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 16/11/2025.
//

import Foundation

struct Constants {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    
    
    static let posterURLString = "https://image.tmdb.org/t/p/w500/"
    //MARK: - test string
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    
    // MARK: - Home view strings
    static let playString = "Play"
    static let trendingMoviesString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMoviesString   = "Top Rated Movies"
    static let topRatedTVString   = "Top Rated TV"
    
    
    static func addPosterPath(to titles: inout[Title]) {
        
        for indx in titles.indices {
            if let path = titles[indx].posterPath {
                titles[indx].posterPath = Constants.posterURLString + path
            }
        }
    }
}
