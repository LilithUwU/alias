//
//  AliasApp.swift
//  Alias
//
//  Created by lilit on 15.01.26.
//

import SwiftUI
import SwiftData

@main
struct AliasApp: App {
    @State private var viewModel = MainViewModel()
    @State private var modelContainer: ModelContainer

    init() {
        do {
            _modelContainer = State(initialValue: try ModelContainer(for: Team.self, GameSession.self))
        } catch {
            fatalError("Failed to initialize the persistent SwiftData store: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .environment(viewModel)
                .modelContainer(modelContainer)
        }
        
    }
}
