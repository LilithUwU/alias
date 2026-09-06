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
struct ConfigureGameScreen: View {
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GridBackground()
            
            ScrollView {
                VStack(spacing: 8) {
                    TimerPickerView(selectedTime: Bindable(viewModel).turnDuration)
                    SliderPickerPickerView(wordCount: Bindable(viewModel).wordCount,
                        title: "Word count")
                    
                    SliderPickerPickerView(
                        wordCount: Bindable(viewModel).winPoints,
                        title: "Winning points"
                    )
                    
                    TeamConfigurationSection(
                        teamName: Bindable(viewModel).team1Name,
                        teamColor: Bindable(viewModel).team1Color,
                        teamNumber: 1
                    )
                    
                    TeamConfigurationSection(
                        teamName: Bindable(viewModel).team2Name,
                        teamColor: Bindable(viewModel).team2Color,
                        teamNumber: 2
                    )
                    
                    NavigationLink(destination: CategoriesScreen()) {
                        Label("Next", systemImage: "arrow.right")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .fontWeight(.semibold)
                    }
                    .disabled(!viewModel.isConfigurationValid)
                    .tint(.pink)
                    .buttonStyle(.borderedProminent)
                    .opacity(viewModel.isConfigurationValid ? 1 : 0.5)
                }
                .padding(20)
            }
        }
        .navigationTitle("Configure Game")
    }
}
