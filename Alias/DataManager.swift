import Foundation
import SwiftData

struct DataManager {
    static func fetchAllTeams(in context: ModelContext) -> [Team] {
        let request = FetchDescriptor<Team>()
        return (try? context.fetch(request)) ?? []
    }

    static func team(named name: String, in context: ModelContext) -> Team? {
        let request = FetchDescriptor<Team>(predicate: #Predicate<Team> { $0.name == name })
        return (try? context.fetch(request))?.first
    }

    @discardableResult
    static func createOrFetchTeam(named name: String, in context: ModelContext) -> Team {
        if let existing = team(named: name, in: context) {
            return existing
        }
        let team = Team(name: name)
        context.insert(team)
        try? context.save()
        return team
    }

    static func incrementGuessed(for name: String, by amount: Int = 1, in context: ModelContext) {
        let team = createOrFetchTeam(named: name, in: context)
        team.guessedCount += amount
        try? context.save()
    }

    static func incrementSkipped(for name: String, by amount: Int = 1, in context: ModelContext) {
        let team = createOrFetchTeam(named: name, in: context)
        team.skippedCount += amount
        try? context.save()
    }

    static func updateLastGameDate(for name: String, date: Date = Date(), in context: ModelContext) {
        let team = createOrFetchTeam(named: name, in: context)
        team.lastGameDate = date
        try? context.save()
    }

    static func recordGame(for name: String, guessed: Int, skipped: Int, date: Date = Date(), in context: ModelContext) {
        let team = createOrFetchTeam(named: name, in: context)
        team.guessedCount += guessed
        team.skippedCount += skipped
        team.lastGameDate = date
        try? context.save()
    }

    static func createTeam(named name: String, for session: GameSession, in context: ModelContext) {
        context.insert(Team(gameSessionID: session.id, name: name))
    }

    static func recordGame(for name: String, session: GameSession, guessed: Int, skipped: Int, date: Date = Date(), in context: ModelContext) {
        let sessionID = session.id
        let request = FetchDescriptor<Team>(predicate: #Predicate<Team> { team in
            team.gameSessionID == sessionID && team.name == name
        })

        if let team = (try? context.fetch(request))?.first {
            team.guessedCount += guessed
            team.skippedCount += skipped
            team.lastGameDate = date
        } else {
            let team = Team(gameSessionID: session.id, name: name, lastGameDate: date, guessedCount: guessed, skippedCount: skipped)
            context.insert(team)
        }
        try? context.save()
    }
}
