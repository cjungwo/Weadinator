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
    VStack {
      imagePicker

      VStack(spacing: CustomSpace.space16) {
        titleTextField

        clothingTypePicker

        warmthLevelPicker

//        AddBtn(action: abc)

      }
      .padding(.horizontal, CustomPadding.padding16)

    }
  }

  var imagePicker: some View {
    VStack {}
  }

  var titleTextField: some View {
    VStack {}
  }

  var clothingTypePicker: some View {
    VStack {}
  }

  var warmthLevelPicker: some View {
    VStack {}
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
