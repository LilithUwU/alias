//
//  StartScreen.swift
//  Alias
//
//  Created by lilit on 18.01.26.
//

import SwiftUI

#Preview{
    StartScreen()
}
struct StartScreen: View {
    private let logoSize: CGFloat = 200
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                GridBackground()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    logo
                    
                    VStack(spacing: 16) {
                        menuButton(
                            title: "Start Game",
                            systemImage: "play.fill",
                            color: .cyan
                        ) {
                            ConfigureGameScreen()
                        }
                        
                        menuButton(
                            title: "Rules",
                            systemImage: "book.fill",
                            color: .pink
                        ) {
                            RulesScreen()
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
    
    private var logo: some View {
        ZStack {
            Image(systemName: "bubble.fill")
                .resizable()
                .scaledToFit()
                .frame(width: logoSize + 70)
                .foregroundStyle(.pink)
            
            Text("Alias")
                .font(.system(size: 70, weight: .bold))
                .foregroundStyle(.black)
                .offset(x: 4, y: -17)
            
            Text("Alias")
                .font(.system(size: 70, weight: .bold))
                .foregroundStyle(.white)
                .offset(y: -16)
        }
    }
    
    @ViewBuilder
    private func menuButton<Destination: View>(
        title: String,
        systemImage: String,
        color: Color,
        @ViewBuilder destination: @escaping () -> Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: systemImage)
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
