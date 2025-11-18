//
//  HomeContent.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import SwiftUI

struct HomeContent: View {
    let heroImageURL: URL?
    let trendingMovies: [Title]?
    let trendingTV: [Title]?
    let topRatedMovies: [Title]?
    let topRatedTV: [Title]?
    let heroHeight: CGFloat
    
    var body: some View {
        LazyVStack {
            heroSection
            
            actionButtons
            
            HorizontalListView(header: Constants.trendingMoviesString,
                               titles: trendingMovies ?? [])
            
            HorizontalListView(header: Constants.trendingTVString,
                               titles: trendingTV ?? [])
            
            HorizontalListView(header: Constants.topRatedMoviesString,
                               titles: topRatedMovies ?? [])
            
            HorizontalListView(header: Constants.topRatedTVString,
                               titles: topRatedTV ?? [])
        }
    }
    
    private var heroSection: some View {
        AsyncImage(url: heroImageURL) { image in
            image
                .resizable()
                .scaledToFit()
                .overlay {
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0.8),
                            .init(color: .gradient, location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
        } placeholder: {
            ProgressView()
        }
        .frame(height: heroHeight)
    }
    
    private var actionButtons: some View {
        HStack {
            Button {
            } label: {
                Text(Constants.playString)
                    .ghostButtonStyle()
            }
            
            Button {
            } label: {
                Text(Constants.downloadString)
                    .ghostButtonStyle()
            }
        }.padding(.vertical)
    }
}

#Preview {
    HomeContent(
        heroImageURL: URL(string: Constants.testTitleURL),
        trendingMovies: [],
        trendingTV: [],
        topRatedMovies: [],
        topRatedTV: [],
        heroHeight: 800
    )
}

