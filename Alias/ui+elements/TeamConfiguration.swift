//
//  TeamConfigurationSection.swift
//  Alias
//
//  Created by lilit on 14.06.26.
//
import SwiftUI

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
