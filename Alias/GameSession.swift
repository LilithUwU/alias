import Foundation
import SwiftData

@Model
final class GameSession {
    @Attribute(.unique) var id: UUID
    var team1Name: String
    var team2Name: String
    var team1Points: Int
    var team2Points: Int
    var winPoints: Int
    var turnDuration: Int = 60
    var activeTeamName: String
    var isFinished: Bool
    var createdAt: Date

    init(
        id: UUID = UUID(),
        team1Name: String,
        team2Name: String,
        winPoints: Int,
        turnDuration: Int = 60,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.team1Name = team1Name
        self.team2Name = team2Name
        self.team1Points = 0
        self.team2Points = 0
        self.winPoints = winPoints
        self.turnDuration = turnDuration
        self.activeTeamName = team1Name
        self.isFinished = false
        self.createdAt = createdAt
    }
}
