import SwiftUI

struct GridBackground: View {
    let gridSpacing: CGFloat = 30
    let lineColor: Color = Color.cyan.opacity(0.3)
    let lineWidth: CGFloat = 0.5

    var body: some View {
        ZStack {
            // Dark Background
            Color(red: 0.05, green: 0.05, blue: 0.05)
                .ignoresSafeArea()

            // Grid Pattern
            Canvas { context, size in
                var path = Path()

                // Draw vertical lines
                for x in stride(from: 0, through: size.width, by: gridSpacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                }

                // Draw horizontal lines
                for y in stride(from: 0, through: size.height, by: gridSpacing) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                }

                context.stroke(path, with: .color(lineColor), lineWidth: lineWidth)
            }
            .ignoresSafeArea()
        }
    }
}
