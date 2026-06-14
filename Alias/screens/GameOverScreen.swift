//
//  GameOverScreen.swift
//  Alias
//
//  Created by lilit on 14.06.26.
//
import SwiftUI

struct GameOverScreen: View {
    var correctCount: Int
    var skippedCount: Int
    var teamName: String
    private var total: Int {
        correctCount
    }
    
    init(correctCount: Int, skippedCount: Int, teamName: String) {
        self.correctCount = correctCount
        self.skippedCount = skippedCount
        self.teamName = teamName
    }
    
    var body: some View {
        VStack{
            Text("\(teamName) team statistics")
            Text("Correct: \(correctCount)")
            Text("Skipped: \(skippedCount)")
            
            Text("Gained \(correctCount) points")
            Text("Total: \(total) points")
        }
    }
}
