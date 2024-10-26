//
//  AddClothingView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 21/10/2024.
//

import SwiftUI
import PhotosUI

struct AddClothingView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext

  @StateObject var manager: ClothingManager = .init()
  @StateObject var viewModel: WardrobeViewModel = .init()


  var body: some View {
    VStack(spacing: CustomSpace.space24) {
      imagePicker

      VStack(spacing: CustomSpace.space16) {
        titleTextField

        clothingColorPicker

        clothingTypePicker

        warmthLevelPicker
      }
      .padding(.horizontal, CustomPadding.padding16)

      LargeButtonStyle(title: "Add") {
        modelContext.insert(manager.createNewClothing())
        do {
          try modelContext.save()
          print("SUCCESS: Weather data added successfully")
        } catch {
          print("ERROR: Failed to save data - \(error)")
        }
        print("DEBUG: Added new model")
        dismiss()
      }
        .padding(.horizontal, CustomPadding.padding16)
    }
    .toolbar(.hidden, for: .tabBar)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .cancellationAction) {
        Button {
          viewModel.isAlertMode.toggle()
        } label: {
          Image(systemName: "xmark")
            .bold()
        }

      }
    }
    .alert("", isPresented: $viewModel.isAlertMode) {
      Button("Discard", role: .destructive) {
        dismiss()
      }

    } message: {
      Text("If you go back now, your clothing will be discarded.")
    }
  }

  //MARK: - imagePicker
  var imagePicker: some View {
    VStack {
      if let data = manager.selectedImageData, let uiImage = UIImage(data: data) {
        Image(uiImage: uiImage)
          .resizable()
          .aspectRatio(2/3, contentMode: .fit)
      } else {
        Rectangle()
          .fill(.gray.opacity(0.5))
          .aspectRatio(2/3, contentMode: .fit)
          .overlay {
            PhotosPicker(selection: $manager.selectedImage, matching: .images, photoLibrary: .shared()) {
              Label("Add Clothing Image", systemImage: "photo")
            }
            .foregroundStyle(.black)
          }
      }
    }
    .overlay {
      if manager.selectedImageData != nil {
        HStack {
          PhotosPicker(selection: $manager.selectedImage, matching: .images, photoLibrary: .shared()) {
            Label("Change", systemImage: "photo")
              .bold()
          }

          Spacer()
            .frame(width: 24)

          Button(role: .destructive) {
            withAnimation {
              manager.selectedImage = nil
              manager.selectedImageData = nil
            }
          } label: {
            Label("Remove", systemImage: "trash")
              .foregroundStyle(.red)
              .bold()
          }
        }
        .frame(height: 48)
        .hSpacing(.center)
        .background(.white.opacity(0.8))
        .vSpacing(.bottom)
      }
    }
    .task(id: manager.selectedImage) {
      if let data = try? await manager.selectedImage?.loadTransferable(type: Data.self) {
        manager.selectedImageData = data
      }
    }
  }

  //MARK: - titleTextField
  var titleTextField: some View {
    HStack {
      Text("Title: ")
        .labelText

      TextField(manager.title, text: $manager.title, prompt: Text("Alias"))
    }
  }

  //MARK: - clothingTypePicker
  var clothingTypePicker: some View {
    HStack {
      Image(systemName: "tshirt")
        .bold()

      Text("Clothing Type: ")
        .labelText

      Spacer()

      Picker("ClothingType", selection: $manager.clothingType) {
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
        .bold()

      Text("Warmth Level: ")
        .labelText
        .padding(.leading, CustomPadding.padding8)

      Spacer()

      Picker("WarmthLevel", selection: $manager.warmthLevel) {
        ForEach(WarmthLevel.allCases, id: \.self) { level in
          Text(level.rawValue.capitalized)
        }
      }
    }
    .padding(.leading, CustomPadding.padding4)
  }

  //MARK: - clothingColorPicker
  var clothingColorPicker: some View {
    HStack {
      Image(systemName: "paintpalette")
        .bold()

      Text("Clothing Color: ")
        .labelText
        .padding(.leading, CustomPadding.padding4)

      Spacer()

      Picker("ClothingColor", selection: $manager.clothingColor) {
        ForEach(ClothingColor.allCases, id: \.self) { color in
          Text(color.rawValue.capitalized)
        }
      }
    }
  }
}


#Preview {
  NavigationStack {
    AddClothingView()
  }
}
