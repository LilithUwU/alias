import SwiftUI

#Preview {
    RulesScreen()
}

struct RulesScreen: View {
    @State var rules: String = "Loading..."
    @StateObject private var languageUtil = LanguageUtil()
    @GestureState private var scale: CGFloat = 1.0
        @State private var finalScale: CGFloat = 1.0
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GridBackground().blur(radius: 2)
            
            Image("rules")
                       .resizable()
                       .scaledToFit()
                       .padding()
                       .scaleEffect(scale * finalScale)
                       .gesture(
                           MagnifyGesture()
                               .updating($scale) { value, gestureState, _ in
                                   gestureState = value.magnification
                               }
                               .onEnded { value in
                                   finalScale *= value.magnification
                               }
                       )
            
//            ScrollView {
//                Text(rules.replacingOccurrences(of: "\\n", with: "\n"))
//                    .font(.body)
//                    .lineSpacing(4)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
        }
        .navigationTitle("Rules")
        .onAppear {
            rules = languageUtil.getRulesFromJSON(key: "gameRules")
        }
    }
}
