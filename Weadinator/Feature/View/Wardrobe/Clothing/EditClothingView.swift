//
//  EditClothingView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 26/10/2024.
//

import SwiftUI
import PhotosUI

struct EditClothingView: View {
  @Environment(\.modelContext) private var modelContext

  @StateObject private var manager: ClothingManager = .init()

  @Bindable var clothing: Clothing
  @Binding var isEditMode: Bool

    var body: some View {
      VStack {
        VStack {
          if clothing.clothingImage != nil {
            Image(uiImage: UIImage(data: clothing.clothingImage!)!)
              .resizable()
              .aspectRatio(2/3, contentMode: .fit)
          } else {
            Rectangle()
              .fill(CustomColor.color3)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
        .overlay {
          HStack {
            PhotosPicker(selection: $manager.selectedImage, matching: .images, photoLibrary: .shared()) {
              Label("Change", systemImage: "photo")
            }

            Spacer()
              .frame(width: 24)

            Button(role: .destructive) {
              withAnimation {
                manager.selectedImage = nil
                clothing.clothingImage = nil
              }
            } label: {
              Label("Remove", systemImage: "trash")
                .foregroundStyle(.red)
            }
          }
          .frame(height: 48)
          .hSpacing(.center)
          .background(.white.opacity(0.8))
          .vSpacing(.bottom)
        }
        .onChange(of: manager.selectedImage) {
          Task {
            if let data = try? await manager.selectedImage?.loadTransferable(type: Data.self) {
              clothing.clothingImage = data
            }
          }
        }
        .clipShape(RoundedRectangle(cornerRadius: CustomRadius.radius16))
        .shadow(radius: CustomRadius.radius4, x: 0, y: 1)

        VStack(alignment: .leading, spacing: CustomSpace.space8) {
          TextField(clothing.title.capitalized, text: $clothing.title)
            .padding(.vertical, CustomPadding.padding8)


          HStack {
            Text("Color: ")
              .labelText

            Picker("ClothingColor", selection: $clothing.clothingColor) {
              ForEach(ClothingColor.allCases, id: \.self) { color in
                Text(color.rawValue.capitalized)
              }
            }
          }

          HStack {
            Text("Style: ")
              .labelText

            Picker("ClothingType", selection: $clothing.clothingType) {
              ForEach(ClothingType.allCases, id: \.self) { type in
                Text(type.rawValue.capitalized)
              }
            }

            Text("for")

            Picker("WarmthLevel", selection: $clothing.warmthLevel) {
              ForEach(WarmthLevel.allCases, id: \.self) { level in
                Text(level.rawValue.capitalized)
              }
            }
          }

          LargeButtonStyle(title: "Done") {
            if !manager.checkTypeInTitle(clothing: clothing) {
              clothing.title = manager.customTitle(clothing: clothing)
            }
            isEditMode = false
          }
        }
        .hSpacing(.leading)
        .padding(.horizontal, CustomPadding.padding16)
      }
      .padding(.top, CustomPadding.padding8)

    }
}

#Preview {
  EditClothingView(clothing: .init(clothingType: .jacket, warmthLevel: .warm, clothingColor: .blue), isEditMode: .constant(true))
}
