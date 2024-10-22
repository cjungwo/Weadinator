//
//  AddClothingView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 21/10/2024.
//

import SwiftUI
import PhotosUI

struct AddClothingView: View {
  @StateObject var manager: ClothingManager = .init()

  var body: some View {
    VStack(spacing: CustomSpace.space24) {
      imagePicker

      VStack(spacing: CustomSpace.space16) {
        titleTextField

        clothingTypePicker

        warmthLevelPicker
      }
      .padding(.horizontal, CustomPadding.padding16)

      AddBtn(action: manager.addBtnTapped)
        .padding(.horizontal, CustomPadding.padding16)
    }
  }

  //MARK: - imagePicker
  var imagePicker: some View {
    VStack {
      if let data = manager.clothing.clothingImage, let uiImage = UIImage(data: data) {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFill()
          .frame(width: .infinity, height:  300)
      } else {
        Rectangle()
          .fill(.gray.opacity(0.5))
          .frame(width: .infinity, height: 300)
          .overlay {
            PhotosPicker(selection: $manager.selectedImage, matching: .images, photoLibrary: .shared()) {
              Label("Add Your Clothing Image", systemImage: "photo")
            }
            .foregroundStyle(.black)
          }
      }
    }
    .overlay {
      if manager.clothing.clothingImage != nil {
        HStack {
          PhotosPicker(selection: $manager.selectedImage, matching: .images, photoLibrary: .shared()) {
            Label("Change", systemImage: "photo")
          }

          Spacer()
            .frame(width: 32)

          Button(role: .destructive) {
            withAnimation {
              manager.selectedImage = nil
              manager.clothing.clothingImage = nil
            }
          } label: {
            Label("Remove", systemImage: "trash")
              .foregroundStyle(.red)
          }
        }
        .frame(height: 48)
        .hSpacing(.center)
        .background(.black.opacity(0.8))
        .vSpacing(.bottom)
      }
    }
    .task(id: manager.selectedImage) {
      if let data = try? await manager.selectedImage?.loadTransferable(type: Data.self) {
        manager.clothing.clothingImage = data
      }
    }
  }

  //MARK: - titleTextField
  var titleTextField: some View {
    HStack {
      Text("Title: ")

      TextField(manager.title, text: $manager.clothing.title, prompt: Text("Alias"))
    }
  }

  //MARK: - clothingTypePicker
  var clothingTypePicker: some View {
    HStack {
      Image(systemName: "tshirt")

      Text("Clothing Type: ")

      Spacer()

      Picker("ClothingType", selection: $manager.clothing.clothingType) {
        ForEach(ClothingType.allCases, id: \.self) { type in
          Text(type.rawValue.capitalized)
        }
      }
    }
  }

  //MARK: - warmthLevelPicker
  var warmthLevelPicker: some View {
    HStack {
      Image(systemName: "thermometer.variable")

      Text("Warmth Level: ")

      Spacer()

      Picker("WarmthLevel", selection: $manager.clothing.warmthLevel) {
        ForEach(WarmthLevel.allCases, id: \.self) { level in
          Text(level.rawValue.capitalized)
        }
      }
    }
  }

}

// MARK: - AddBtn
private struct AddBtn: View {
  var action: () -> Void

  init(
    action: @escaping () -> Void
  ) {
    self.action = action
  }

  fileprivate var body: some View {
    Button {
      action()
    } label: {
      Text("Add")
        .font(.system(size: 16, weight: .bold))
        .foregroundStyle(.white)
    }
    .padding(CustomPadding.padding16)
    .hSpacing(.center)
    .background(CustomColor.backgroundColor)
    .cornerRadius(CustomRadius.radius8)
  }
}



#Preview {
  AddClothingView()
}
