//
//  ClothingDetailView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 22/10/2024.
//

import SwiftUI

struct ClothingDetailView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss

  @Bindable var clothing: Clothing

  @State private var isEditMode: Bool = false
  @State private var isAlertMode: Bool = false

  var body: some View {
    VStack {
      VStack {
        if clothing.clothingImage != nil {
          Image(uiImage: UIImage(data: clothing.clothingImage!)!)
            .resizable()
        } else {
          Rectangle()
            .fill(CustomColor.color3)
        }
      }
      .ignoresSafeArea(edges: .top)
      .frame(height: UIScreen.main.bounds.height / 2 - 52)

      VStack(alignment: .leading, spacing: CustomSpace.space8) {
        Text(clothing.title.capitalized)
          .title2Text
          .lineLimit(1)
          .padding(.vertical, CustomPadding.padding8)

        HStack {
          Text("Color: ")
            .labelText

          Text(clothing.clothingColor.rawValue)
        }

        HStack {
          Text("Style: ")
            .labelText

          Text("\(clothing.clothingType.rawValue.capitalized) for \(clothing.warmthLevel) weather")
        }

        Spacer()

        LargeButtonStyle(title: "Edit") {
          isEditMode.toggle()
        }
        .padding(.vertical, CustomPadding.padding8)

        LargeButtonStyle(title: "Remove", bgColor: CustomColor.color4, fgColor: .white) {
          isAlertMode.toggle()
        }
        .padding(.vertical, CustomPadding.padding8)
      }
      .hSpacing(.leading)
      .padding(.horizontal, CustomPadding.padding16)
    }
    .vSpacing(.top)
    .tint(.black)
    .sheet(isPresented: $isEditMode) {
      EditClothingView(clothing: clothing, isEditMode: $isEditMode)
    }
    .alert("Remove \(clothing.title.capitalized)", isPresented: $isAlertMode) {
      Button("Remove", role: .destructive) {
        modelContext.delete(clothing)
        isAlertMode.toggle()
        dismiss()
      }
    }
    .toolbar(.hidden, for: .tabBar)

  }
}

#Preview {
  NavigationStack {
    ClothingDetailView(clothing: .init(clothingType: .jacket, warmthLevel: .warm, clothingColor: .blue))
  }
}
