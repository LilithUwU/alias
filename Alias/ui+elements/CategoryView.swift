import SwiftUI

#Preview{
    CategoryView(iconName: "star", name: "Starred", topicCount: 12)
}
struct CategoryView: View {
    
    let iconName: String
    let name: String
    let topicCount: Int
    
    private let iconSize: CGFloat = 70
    
    var body: some View {
        HStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Topic")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .italic()
                
                Text("\(topicCount) words")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(iconName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(.pink)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.red.opacity(0.1))
                .stroke(.red, lineWidth: 2)
        )
    }
}
