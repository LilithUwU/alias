import SwiftUI

struct ContentView: View {
    @State private var words: [String] = []
    @StateObject private var languageUtil = LanguageUtil()
    
    var body: some View {
        NavigationStack {
            ZStack {
                GridBackground()
                
                List(words, id: \.self) { word in
                   
                    NavigationLink {
                      
                        GameScreen()
                    } label: {
                       
                        Text(word)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Words")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
            .onAppear {
                words = languageUtil.loadJSON(category: .animals) ?? []
            }
        }
    }


#Preview {
    ContentView()
}
