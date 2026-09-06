//
//  ViewModel.swift
//  Alias
//
//  Created by lilit on 15.06.26.
//

import SwiftUI
import Observation
import SwiftData

enum AppRoute: Hashable {
    case configure
    case history
    case rules
    case categories
    case game
    case gameOver
}

struct TurnResult: Equatable {
    let correctCount: Int
    let skippedCount: Int
    let teamName: String
    let nextTeamName: String
}

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
    private(set) var team1Points: Int = 0
    private(set) var team2Points: Int = 0
    var navigationPath = NavigationPath()
    var activeSession: GameSession?
    var turnResult: TurnResult?
    
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
        words = words.shuffled()
        return words
    }

    func addPoint(for teamName: String) {
        if teamName == team1Name {
            team1Points += 1
        } else if teamName == team2Name {
            team2Points += 1
        }
    }

    func addPoint(for teamName: String, in session: GameSession) {
        addPoint(for: teamName)
        if teamName == session.team1Name {
            session.team1Points += 1
        } else if teamName == session.team2Name {
            session.team2Points += 1
        }
    }

    func totalPoints(for teamName: String) -> Int {
        teamName == team1Name ? team1Points : team2Points
    }

    func resetGameScores() {
        team1Points = 0
        team2Points = 0
    }

    func startGame(in context: ModelContext) -> GameSession {
        resetGameScores()
        let session = GameSession(
            team1Name: team1Name,
            team2Name: team2Name,
            winPoints: winPoints,
            turnDuration: turnDuration
        )
        context.insert(session)
        DataManager.createTeam(named: team1Name, for: session, in: context)
        DataManager.createTeam(named: team2Name, for: session, in: context)
        try? context.save()
        activeSession = session
        return session
    }

    func resumeGame(_ session: GameSession) {
        team1Name = session.team1Name
        team2Name = session.team2Name
        winPoints = session.winPoints
        turnDuration = session.turnDuration
        team1Points = session.team1Points
        team2Points = session.team2Points
        activeSession = session
    }

    func presentGameOver(correctCount: Int, skippedCount: Int, teamName: String) {
        guard let activeSession else { return }
        let nextTeamName = teamName == activeSession.team1Name ? activeSession.team2Name : activeSession.team1Name
        turnResult = TurnResult(
            correctCount: correctCount,
            skippedCount: skippedCount,
            teamName: teamName,
            nextTeamName: nextTeamName
        )
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
        navigationPath.append(AppRoute.gameOver)
    }

    func recordGame(for teamName: String, session: GameSession, guessed: Int, skipped: Int, in context: ModelContext) {
        DataManager.recordGame(for: teamName, session: session, guessed: guessed, skipped: skipped, in: context)
    }

    // MARK: - SwiftData helpers

    func recordGuessed(for teamName: String, in context: ModelContext) {
        DataManager.incrementGuessed(for: teamName, in: context)
    }

    func recordSkipped(for teamName: String, in context: ModelContext) {
        DataManager.incrementSkipped(for: teamName, in: context)
    }

    func updateLastGameDate(for teamName: String, date: Date = Date(), in context: ModelContext) {
        DataManager.updateLastGameDate(for: teamName, date: date, in: context)
    }

    func ensureTeamsExist(in context: ModelContext) {
        DataManager.createOrFetchTeam(named: team1Name, in: context)
        DataManager.createOrFetchTeam(named: team2Name, in: context)
    }
}

