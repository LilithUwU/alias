import SwiftUI

struct ContentView: View {
    @State private var words: [String] = []
    @StateObject private var languageUtil = LanguageUtil()
    
    var body: some View {
        NavigationView {
            VStack {
                List(words, id: \.self) { word in
                    Text(word)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle("Words")
            .onAppear {
                words = languageUtil.loadJSON(category: .animals) ?? []
            }
        }
    }
}

#Preview {
    ContentView()
}
