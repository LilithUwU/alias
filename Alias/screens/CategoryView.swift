import SwiftUI

#Preview{
    ForEach(Categories.allCases, id: \.self) {
        CategoryView(
            iconName: $0.rawValue,
            name: $0.rawValue.capitalized,
        )
    }
}

struct CategoryView: View {
    var iconName: String = "movieclapper"
    var name: String = "Movies"
    var count: String = "100"
    let size: CGFloat = 70
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Topic")
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .italic()
                Text(count)

                
//                Button("Select") {
//                    print("Category selected")
//                }
//                .padding(8)
//                .frame(maxWidth: .infinity)
//                .background(Color.pink)
//                .foregroundColor(.white)
//                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(iconName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: size, height: size)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.pink)
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .border(.red, width: 3)
        .onTapGesture {
            print("Category selected")        }
    }
}
