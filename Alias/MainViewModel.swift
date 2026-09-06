//
//  ViewModel.swift
//  Alias
//
//  Created by lilit on 15.06.26.
//

import SwiftUI
import Observation

@MainActor
@Observable
class MainViewModel {
    private var languageUtil = LanguageUtil()
    
    var team1Name: String = "Team 1"
    var team1Color: Color = .red
    var team2Name: String = "Team 2"
    var team2Color: Color = .blue
    var wordCount: Int = 10
    var winPoints: Int = 10
    var turnDuration: Int = 60
    
    var isConfigurationValid: Bool {
        !team1Name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !team2Name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var jsonData: JsonCategories?
    var selectedCategory: Categories = .animals
    
    
    init() {
        loadFullJSON()
    }
    
    func loadFullJSON() {
        self.jsonData = languageUtil.loadAllData()
    }
    
    var currentWords: [String] {
        guard let data = jsonData else { return [] }
        var words = data.words(for: selectedCategory)
        if selectedCategory == .mixed {
            words = words.shuffled()
        }
        return words
    }
}

