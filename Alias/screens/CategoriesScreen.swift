//
//  CategoriesScreen.swift
//  Alias
//
//  Created by lilit on 18.01.26.
//

import SwiftUI

struct CategoriesScreen: View {
    @Environment(MainViewModel.self) private var viewModel
    let gameSession: GameSession

    init(gameSession: GameSession) {
        self.gameSession = gameSession
    }

    var body: some View {
        ZStack {
            GridBackground()
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Button {
                            viewModel.selectedCategory = category
                            viewModel.navigationPath.removeLast()
                            viewModel.navigationPath.append(AppRoute.game)
                        } label: {
                            CategoryView(
                                // png icons from assets
                                iconName: category.iconName,
                                name: category.displayName.capitalized,
                                topicCount: viewModel.jsonData?.words(for: category).count ?? 0
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Words")
    }
}
