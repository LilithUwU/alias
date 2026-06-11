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
    let size: CGFloat = 200
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                GridBackground()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "message.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)
                            .foregroundStyle(Color.pink)
                        Text("Alias")
                            .font(Font.largeTitle.bold())
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        ConfigureGameScreen()
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Start Game").font(Font.title.bold())
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.cyan)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    NavigationLink {
                        RulesScreen()
                    } label: {
                        HStack {
                            Image(systemName: "book.fill")
                            Text("Rules").font(Font.title.bold())
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
        }
    }
}
