//
//  ContentView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 9/10/2024.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
  var body: some View {
    TabView {
      Tab {
        HomeView()
      } label: {
        Label("Home", systemImage: "cloud.sun")
      }

      Tab {
        WardrobeView()
      } label: {
        Label("Wardrobe", systemImage: "door.french.closed")
      }
    }
  }
}

#Preview {
  MainTabView()
    .modelContainer(for: [Clothing.self], inMemory: true)
}
