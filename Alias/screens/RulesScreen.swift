import SwiftUI

#Preview {
    RulesScreen()
}

struct RulesScreen: View {
    @State var rules: String = "Loading..."
    @StateObject private var languageUtil = LanguageUtil()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GridBackground()
            
            ScrollView {
                Text(rules.replacingOccurrences(of: "\\n", with: "\n"))
                    .foregroundColor(.white)
                    .font(.body)
                    .lineSpacing(4)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Rules")
        .onAppear {
            rules = languageUtil.getRulesFromJSON(key: "gameRules")
        }
    }
}
