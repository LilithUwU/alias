//
//  AliasApp.swift
//  Alias
//
//  Created by lilit on 15.01.26.
//

import SwiftUI

@main
struct AliasApp: App {
    @State private var viewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .environment(viewModel)
        }
        
    }
}
