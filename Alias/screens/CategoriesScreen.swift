//
//  CategoriesScreen.swift
//  Alias
//
//  Created by lilit on 18.01.26.
//

import SwiftUI

#Preview {
    CategoriesScreen()
}
struct CategoriesScreen: View {
    @Environment(MainViewModel.self) private var viewModel
    @State private var navigatedCategory: Categories? = nil

    var body: some View {
        ZStack {
            GridBackground()
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Button {
                            viewModel.selectedCategory = category
                            navigatedCategory = category
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
        .navigationDestination(item: $navigatedCategory) { _ in
            GameScreen()
        }
        .navigationTitle("Words")
    }
}
