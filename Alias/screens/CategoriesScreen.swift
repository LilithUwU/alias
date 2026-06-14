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
    var body: some View {
        NavigationStack {
            ZStack {
                GridBackground()
                List(Categories.allCases, id: \.self) { category in
                    NavigationLink {
                        GameScreen()
                    } label: {
                        CategoryView(
                            iconName: category.rawValue,
                            name: category.displayName.capitalized
                        )
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Words")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
