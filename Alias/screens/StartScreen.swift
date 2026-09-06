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
    @Environment(MainViewModel.self) private var viewModel
    private let logoSize: CGFloat = 200
    
    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Color.black.ignoresSafeArea()
                GridBackground()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    logo
                    
                    VStack(spacing: 16) {
                        menuButton(
                            title: "Start Game",
                            systemImage: "plus.circle.fill",
                            color: .cyan,
                            route: .configure
                        )
                        
                        menuButton(
                            title: "Continue game",
                            systemImage:  "play.fill",
                            color: .gray,
                            route: .history
                        )
                        
                        menuButton(
                            title: "Rules",
                            systemImage: "book.fill",
                            color: .pink,
                            route: .rules
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                destination(for: route)
            }
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .configure:
            ConfigureGameScreen()
        case .history:
            HistoryScreen()
        case .rules:
            RulesScreen()
        case .categories:
            if let session = viewModel.activeSession {
                CategoriesScreen(gameSession: session)
            }
        case .game:
            if let session = viewModel.activeSession {
                GameScreen(teamName: session.activeTeamName, gameSession: session)
            }
        case .gameOver:
            if let session = viewModel.activeSession, let result = viewModel.turnResult {
                GameOverScreen(
                    correctCount: result.correctCount,
                    skippedCount: result.skippedCount,
                    teamName: result.teamName,
                    nextTeamName: result.nextTeamName,
                    gameSession: session
                )
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
    private func menuButton(
        title: String,
        systemImage: String,
        color: Color,
        route: AppRoute
    ) -> some View {
        NavigationLink(value: route) {
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
