//
//  HomeView.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 16/11/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isRefreshing = UUID()
    var heroTestTitle = Constants.testTitleURL
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                switch viewModel.loadingState {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height )
                case .success(let data):
                    HomeContent(
                        heroImageURL: URL(string: Constants.testTitleURL),
                        trendingMovies: data?.trendingMovies,
                        trendingTV: data?.trendingTV,
                        topRatedMovies: data?.topRatedMovies,
                        topRatedTV: data?.topRatedTV,
                        heroHeight: geo.size.height * 0.85
                    )
                case .failed(let error):
                    VStack(alignment: .center) {
                        Spacer()
                        Text(error.localizedDescription)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding()
                        Spacer()
                    }.frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .task {
                await viewModel.getTitles()
            }
        }.refreshable {
            refreshData()
        }
    }
    
    private func refreshData() {
        Task {
            await viewModel.getTitles(forceRefresh: true)
        }
    }
}


#Preview {
    HomeView().preferredColorScheme(.light)
}
