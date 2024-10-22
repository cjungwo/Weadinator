//
//  WardrobeView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import SwiftData

struct WardrobeView: View {
  @Query var clothingList: [Clothing]

  @StateObject private var viewModel: WardrobeViewModel = .init()

  var body: some View {
    NavigationStack {
      VStack(spacing: CustomSpace.space16) {
        if clothingList.isEmpty {
          EmptyClothingListView()
            .vSpacing(.center)
            .hSpacing(.center)
        } else {
          ScrollView {
            ForEach(clothingList) { clothing in
              ClothingItemView(of: clothing)
            }
          }
          .scrollIndicators(.hidden)
        }
      }
      .navigationTitle("Wardrobe")
      .toolbar {
        ToolbarItem {
          addBtn
        }
      }
      .sheet(isPresented: $viewModel.isAddMode) {
        AddClothingView()
      }
    }
  }

  var addBtn: some View {
    Button {
      viewModel.isAddMode.toggle()
    } label: {
      HStack {
        Image(systemName: "plus")
          .imageScale(.small)
          .bold()

        Text("Add")
          .font(.system(size: 16, weight: .medium))
      }
      .foregroundStyle(CustomColor.color1)
      .padding(.horizontal, CustomPadding.padding8)
      .padding(.vertical, CustomPadding.padding8)
      .cornerRadius(CustomRadius.radius4)
      .overlay(
        RoundedRectangle(cornerRadius: CustomRadius.radius4)
          .inset(by: -0.25)
          .stroke(CustomColor.color1, style: StrokeStyle(lineWidth: 0.5, dash: [1, 1]))
      )
    }
  }
}

#Preview {
  WardrobeView()
    .modelContainer(ModelContainer.mock)
    .onAppear {
      PreviewHelper.addMockData(context: ModelContainer.mock.mainContext)
    }
}
