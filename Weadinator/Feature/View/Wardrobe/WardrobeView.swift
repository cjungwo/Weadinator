//
//  WardrobeView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import SwiftData

struct WardrobeView: View {
  @Environment(\.modelContext) var modelContext
  
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
            ForEach(ClothingType.allCases, id: \.self) { type in
              categoryList(of: type)
            }
          }
          .padding(.leading, CustomPadding.padding16)
        }
      }
      .navigationTitle("Wardrobe")
      .toolbar {
        ToolbarItem {
          toolBarAddBtn
        }
      }
      .sheet(isPresented: $viewModel.isAddMode) {
        AddClothingView()
      }
    }
    .onAppear {
      print("DEBUG: WardrobeView onAppear")
    }
    .onChange(of: clothingList) { oldValue, newValue in
      print("DEBUG: Old value: \(oldValue)")
      print("DEBUG: New value: \(newValue)")
    }
  }

  @ViewBuilder
  private func categoryList(of type: ClothingType) -> some View {
    VStack {
      HStack {
        Text(type.rawValue.capitalized)
          .title3Text
      }
      .hSpacing(.leading)

      ScrollView(.horizontal) {
        HStack {
          if clothingList.filter({ $0.clothingType == type }).isEmpty {
            NavigationLink {
              AddClothingView()
            } label: {
              CardStyleAddBtn()
            }
          } else {
            ForEach(clothingList.filter { $0.clothingType == type }) { clothing in
              ClothingItemView(of: clothing)
            }
          }
        }
      }
      .scrollIndicators(.hidden)
    }
  }

  //MARK: - toolBarAddBtn
  var toolBarAddBtn: some View {
    NavigationLink {
      AddClothingView()
    } label: {
      HStack {
        Image(systemName: "plus")
          .imageScale(.small)
          .bold()

        Text("Add")
          .btnText
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

//MARK: - CardStyleAddBtn
private struct CardStyleAddBtn: View {
  fileprivate var body: some View {
    VStack {
        Image(systemName: "plus.app")
        .resizable()
        .frame(width: 36, height: 36)
      }
    .frame(width: 100, height: 140)
    .clipShape(RoundedRectangle(cornerRadius: CustomRadius.radius4))
    .overlay {
      RoundedRectangle(cornerRadius: CustomRadius.radius4)
        .inset(by: -0.25)
        .stroke(CustomColor.color1, style: StrokeStyle(lineWidth: 0.5, dash: [1, 1]))
    }
  }
}

#Preview {
  WardrobeView()
    .modelContainer(for: [Clothing.self], inMemory: true)
}
