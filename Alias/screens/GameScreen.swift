//
//  GameScreen.swift
//  Alias
//
//  Created by lilit on 18.01.26.
//

import SwiftUI
#Preview {
    GameScreen()
}
struct GameScreen: View {
    @State private var progress: Float = 20
    @State private var time: String = "00:00"
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GridBackground()
            
            VStack(spacing: 40) {
                VStack(alignment: .trailing, spacing: 8) {
                    Text("Time left")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.subheadline)
                    
                    Text(time)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                    
                    ProgressView(value: progress, total: 100)
                        .tint(.cyan)
                        .scaleEffect(y: 2)
                    
                    Text("\(Int(progress))%")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.caption)
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(15)
                
                Spacer()
                
                GuessWordView(text: "SpaceX")
                
                Spacer()
                
                HStack(spacing: 20) {
                    MyButton(
                        text: "Skip",
                        icon: "xmark.circle.fill",
                        bgColor: .red,
                        onTap: { print("Skip") }
                    )
                    
                    MyButton(
                        text: "Correct",
                        icon: "checkmark.circle.fill",
                        bgColor: .green,
                        onTap: { print("Correct") }
                    )
                }
            }
            .padding(20)
        }
    }
}


