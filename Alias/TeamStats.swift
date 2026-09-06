import Foundation
import SwiftData

@Model
final class Team {
    @Attribute(.unique) var id: UUID = UUID()
    var gameSessionID: UUID?
    var name: String
    var lastGameDate: Date?
    var guessedCount: Int
    var skippedCount: Int

    init(id: UUID = UUID(), gameSessionID: UUID? = nil, name: String, lastGameDate: Date? = nil, guessedCount: Int = 0, skippedCount: Int = 0) {
        self.id = id
        self.gameSessionID = gameSessionID
        self.name = name
        self.lastGameDate = lastGameDate
        self.guessedCount = guessedCount
        self.skippedCount = skippedCount
    }
}
