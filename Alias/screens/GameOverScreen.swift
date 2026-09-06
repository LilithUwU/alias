//
//  GameOverScreen.swift
//  Alias
//
//  Created by lilit on 14.06.26.
//
import SwiftUI
import SwiftData

struct GameOverScreen: View {
    @Environment(MainViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext
    @State private var didSaveGame = false

    let correctCount: Int
    let skippedCount: Int
    let teamName: String
    let nextTeamName: String
    let gameSession: GameSession

    private var totalPoints: Int {
        teamName == gameSession.team1Name ? gameSession.team1Points : gameSession.team2Points
    }

    private var winPoints: Int {
        gameSession.winPoints
    }

    private var hasWon: Bool {
        totalPoints >= winPoints
    }
    
    var body: some View {
        ZStack {
            GridBackground()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: hasWon ? "trophy.fill" : "arrow.right.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(hasWon ? .yellow : .cyan)

                VStack(spacing: 8) {
                    Text(hasWon ? "We have a winner!" : "Turn complete")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)

                    Text(hasWon ? teamName : "Nice round, \(teamName)")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(hasWon ? .yellow : .cyan)
                }

                VStack(spacing: 16) {
                    scoreRow(title: "This round", value: correctCount, color: .cyan)
                    scoreRow(title: "Total points", value: totalPoints, color: .yellow)
                    scoreRow(title: "Skipped", value: skippedCount, color: .pink)
                }
                .padding(20)
                .background(.black.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.15), lineWidth: 1)
                }

                if hasWon {
                    Text("Reached the winning score of \(winPoints) points")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                } else {
                    Text("First team to reach \(winPoints) points wins")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }

                Spacer()

                if !hasWon {
                    Button {
                        viewModel.navigationPath.removeLast()
                        viewModel.navigationPath.append(AppRoute.categories)
                    } label: {
                        Label("Choose category for \(nextTeamName)", systemImage: "arrow.right")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.cyan)
                    .foregroundColor(.black)
                }

                if hasWon {
                    Button {
                        viewModel.navigationPath = NavigationPath()
                    } label: {
                        Label("Back to start", systemImage: "house.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                }
            }
            .padding(24)
        }
        .navigationTitle(hasWon ? "Winner" : "Round summary")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard !didSaveGame else { return }
            viewModel.recordGame(
                for: teamName,
                session: gameSession,
                guessed: correctCount,
                skipped: skippedCount,
                in: modelContext
            )
            gameSession.isFinished = hasWon
            if !hasWon {
                gameSession.activeTeamName = nextTeamName
            }
            try? modelContext.save()
            didSaveGame = true
        }
    }

    private func scoreRow(title: String, value: Int, color: Color) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.white.opacity(0.75))
            Spacer()
            Text("\(value)")
                .font(.title2.bold())
                .foregroundStyle(color)
        }
    }
}
