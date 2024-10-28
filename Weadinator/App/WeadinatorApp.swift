//
//  WeadinatorApp.swift
//  Weadinator
//
//  Created by JungWoo Choi on 9/10/2024.
//

import SwiftUI
import SwiftData

@main
struct WeadinatorApp: App {

  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Clothing.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

    var body: some Scene {
        WindowGroup {
            MainTabView()
            .modelContainer(sharedModelContainer)
        }
    }
}
