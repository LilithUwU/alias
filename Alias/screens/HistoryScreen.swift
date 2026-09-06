//
//  HistoryScreen.swift
//  Alias
//
//  Created by lilit on 06.09.26.
//

import SwiftUI
import SwiftData

struct HistoryScreen: View {
	@Query(sort: \Team.lastGameDate, order: .reverse)
	private var teams: [Team]
	@Query(sort: \GameSession.createdAt, order: .reverse)
	private var gameSessions: [GameSession]
	@Environment(MainViewModel.self) private var viewModel
	@Environment(\.modelContext) private var modelContext
	@State private var sessionToDelete: GameSession?

	var body: some View {
		ZStack {
			GridBackground()

			ScrollView {
				VStack(alignment: .leading, spacing: 20) {
					if gameSessions.isEmpty {
						ContentUnavailableView(
							"No records yet",
							systemImage: "clock.arrow.circlepath",
							description: Text("Play a game to see team records here.")
						)
						.foregroundStyle(.white)
						.frame(maxWidth: .infinity)
						.padding(.top, 80)
					} else {
						LazyVStack(spacing: 12) {
							ForEach(gameSessions) { session in
								gameRecord(session)
							}
						}
					}
				}
				.padding()
			}
		}
		.navigationTitle("History")
		.navigationBarTitleDisplayMode(.inline)
		.confirmationDialog(
			"Delete this game?",
			isPresented: Binding(
				get: { sessionToDelete != nil },
				set: { isPresented in
					if !isPresented {
						sessionToDelete = nil
					}
				}
			),
			titleVisibility: .visible
		) {
			Button("Delete", role: .destructive) {
				if let sessionToDelete {
					deleteGame(sessionToDelete)
				}
			}
			Button("Cancel", role: .cancel) {
				sessionToDelete = nil
			}
		} message: {
			Text("This will remove both teams and this game from history.")
		}
	}

	private func gameRecord(_ session: GameSession) -> some View {
		let sessionTeams = teams.filter { $0.gameSessionID == session.id }
		let team1 = sessionTeams.first { $0.name == session.team1Name }
		let team2 = sessionTeams.first { $0.name == session.team2Name }

		return VStack(alignment: .leading, spacing: 12) {
			HStack {
				Label(session.isFinished ? "Completed game" : "Game in progress", systemImage: session.isFinished ? "checkmark.circle.fill" : "play.circle.fill")
					.font(.headline)
					.foregroundStyle(.white)

				Spacer()

				Text(session.createdAt, format: .dateTime.day().month().year().hour().minute())
					.font(.caption)
					.foregroundStyle(.white.opacity(0.7))

				Button {
					sessionToDelete = session
				} label: {
					Image(systemName: "trash")
						.foregroundStyle(.red)
				}
				.buttonStyle(.plain)
				.accessibilityLabel("Delete this game and both teams")
			}

			teamSummary(
				name: session.team1Name,
				guessed: team1?.guessedCount ?? session.team1Points,
				skipped: team1?.skippedCount ?? 0,
				color: .cyan
			)
			teamSummary(
				name: session.team2Name,
				guessed: team2?.guessedCount ?? session.team2Points,
				skipped: team2?.skippedCount ?? 0,
				color: .pink
			)

			Text("First to \(session.winPoints) points wins")
				.font(.caption)
				.foregroundStyle(.white.opacity(0.7))

			if !session.isFinished {
				Button {
					viewModel.resumeGame(session)
					viewModel.navigationPath.removeLast()
					viewModel.navigationPath.append(AppRoute.categories)
				} label: {
					Label("Continue as \(session.activeTeamName)", systemImage: "arrow.right")
						.frame(maxWidth: .infinity)
                        .foregroundColor(.black)
				}
				.buttonStyle(.borderedProminent)
				.tint(.cyan)
			}
		}
		.padding()
		.background(.black.opacity(0.7))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(.white.opacity(0.15), lineWidth: 1)
		}
		.clipShape(RoundedRectangle(cornerRadius: 12))
	}

	private func teamSummary(name: String, guessed: Int, skipped: Int, color: Color) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(name)
				.font(.title3.bold())
				.foregroundStyle(.white)
			HStack(spacing: 24) {
				stat(label: "Guessed", value: guessed, color: color)
				stat(label: "Skipped", value: skipped, color: .pink)
			}
		}
	}

	private func deleteGame(_ session: GameSession) {
			for team in teams where team.gameSessionID == session.id {
				modelContext.delete(team)
			}
			modelContext.delete(session)
			try? modelContext.save()
		sessionToDelete = nil
	}

	private func stat(label: String, value: Int, color: Color) -> some View {
		VStack(alignment: .leading, spacing: 2) {
			Text("\(value)")
				.font(.title2.bold())
				.foregroundStyle(color)
			Text(label)
				.font(.caption)
				.foregroundStyle(.white.opacity(0.7))
		}
	}
}

