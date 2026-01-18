import SwiftUI

#Preview {
    ContentView()
}

struct ContentView: View {
    @State private var words: [String] = []
    @StateObject private var languageUtil = LanguageUtil()
    
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
        .onAppear {
            words = languageUtil.loadJSON(category: .animals) ?? []
        }
    }
}
