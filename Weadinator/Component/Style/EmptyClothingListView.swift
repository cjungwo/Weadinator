//
//  EmptyClothingListView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 22/10/2024.
//

import SwiftUI

struct EmptyClothingListView: View {
    var body: some View {
      VStack(spacing: CustomSpace.space16) {
        NavigationLink {
          AddClothingView()
        } label: {
          Image(systemName: "plus.app")
            .resizable()
            .frame(width: 64, height: 64)
        }

        Text("Add your clothes")
          .font(.system(size: 18, weight: .bold))
      }
      .foregroundStyle(CustomColor.color1)
    }
}

#Preview {
  NavigationStack {
      EmptyClothingListView()
    }
}
