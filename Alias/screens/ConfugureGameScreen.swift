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
                VStack(spacing: 24) {
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
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Team Configuration Section
struct TeamConfigurationSection: View {
    @Binding var teamName: String
    @Binding var teamColor: Color
    let teamNumber: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Team \(teamNumber)")
                .font(.headline)
                .foregroundStyle(.white)
            
            TextField("", text: $teamName, prompt: Text("Enter team name").foregroundColor(.white.opacity(0.7)))
                .textFieldStyle(.plain)
                .padding(12)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .foregroundStyle(.white)
                .accessibilityLabel("Team \(teamNumber) name")
            
            ColorPickerView(selectedColor: $teamColor)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.5)))
    }
}

// MARK: - Color Picker
struct ColorPickerView: View {
    private let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .pink]
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Team Color")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 6), spacing: 8) {
                ForEach(colors, id: \.self) { color in
                    Button(action: { selectedColor = color }) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(color)
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Select \(colorName(color)) color")
                }
            }
        }
    }
    
    private func colorName(_ color: Color) -> String {
        switch color {
        case .red: "red"
        case .blue: "blue"
        case .green: "green"
        case .yellow: "yellow"
        case .orange: "orange"
        case .pink: "pink"
        default: "custom"
        }
    }
}

struct TimerPickerView: View {
    @Binding var selectedTime: Int
    
    private let timeOptions = [30, 60, 120]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Turn Duration")
                .font(.headline)
                .foregroundColor(.white)
            
            Picker("Turn Duration", selection: $selectedTime) {
                ForEach(timeOptions, id: \.self) { seconds in
                    Text("\(seconds)s").tag(seconds)
                }
            }
            .pickerStyle(.segmented)
            .tint(.pink)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.5)))
    }
}

// MARK: - Word Count Picker
struct WordCountPickerView: View {
    @Binding var wordCount: Int
    
    private let minWords = 1
    private let maxWords = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Word Count")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("\(wordCount)")
                    .font(.headline)
                    .foregroundStyle(.pink)
            }
            
            Slider(
                value: Binding(
                    get: { Double(wordCount) },
                    set: { wordCount = Int($0) }
                ),
                in: Double(minWords)...Double(maxWords),
                step: 1
            )
            .tint(.pink)
            .accessibilityLabel("Word count slider")
            .accessibilityValue("\(wordCount) words")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.5)))
    }
}

