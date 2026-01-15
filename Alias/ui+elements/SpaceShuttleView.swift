//
//  SpaceShuttleView.swift
//  Alias
//
//  Created by lilit on 15.01.26.
//



import SwiftUI

#Preview{
    SpaceShuttleView()
}

struct SpaceShuttleView: View {
    var body: some View {
        Button(action: {
            print("Blast off!")
        }) {
            Text("SPACE\nSHUTTLE")
//                .font(.custom("PixeloidSans", size: 40))
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .lineSpacing(-5)
            .padding(40)
            .background(CheckeredBackground().foregroundColor(Color("D1548E")))
            .foregroundColor(.white)
            .overlay(Rectangle().stroke(Color.black, lineWidth: 8))
            .background(Rectangle().fill(Color.black)
.offset(x: 10, y: 10)
            )
        }
    }
}

struct CheckeredBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let size: CGFloat = 6
                for y in stride(from: 0, to: geometry.size.height, by: size * 2) {
                    for x in stride(from: 0, to: geometry.size.width, by: size * 2) {
                        path.addRect(CGRect(x: x, y: y, width: size, height: size))
                        path.addRect(CGRect(x: x + size, y: y + size, width: size, height: size))
                    }
                }
            }
            .fill(Color.white.opacity(0.2))
            .background(Color.pink)
        }
    }
}
