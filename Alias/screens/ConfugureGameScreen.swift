//
//  ConfugureGameScreen.swift
//  Alias
//
//  Created by lilit on 11.06.26.
//
import SwiftUI

#Preview {
    NavigationStack {
        ConfigureGameScreen()
    }
}

// MARK: - Models
struct GameConfiguration {
    var team1Name: String = "Team 1"
    var team1Color: Color = .red
    var team2Name: String = "Team 2"
    var team2Color: Color = .blue
    var wordCount: Int = 10
    var turnDuration: Int = 60
    
    var isValid: Bool {
        !team1Name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !team2Name.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

// MARK: - Main Screen
struct ConfigureGameScreen: View {
    @State private var configuration = GameConfiguration()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GridBackground()
            
            ScrollView {
                VStack(spacing: 8) {
                    TimerPickerView(selectedTime: $configuration.turnDuration)
                    WordCountPickerView(wordCount: $configuration.wordCount)
                    
                    TeamConfigurationSection(
                        teamName: $configuration.team1Name,
                        teamColor: $configuration.team1Color,
                        teamNumber: 1
                    )
                    
                    TeamConfigurationSection(
                        teamName: $configuration.team2Name,
                        teamColor: $configuration.team2Color,
                        teamNumber: 2
                    )
                    
                    NavigationLink(destination: CategoriesScreen()) {
                        Label("Next", systemImage: "arrow.right")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .fontWeight(.semibold)
                    }
                    .disabled(!configuration.isValid)
                    .tint(.pink)
                    .buttonStyle(.borderedProminent)
                    .opacity(configuration.isValid ? 1 : 0.5)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
        }
        .navigationTitle("Configure Game")
        .navigationBarTitleDisplayMode(.inline)      .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
