//
//  ClothingItemView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 22/10/2024.
//

import SwiftUI

struct ClothingItemView: View {
  var clothing: Clothing

  init(
    of clothing: Clothing
  ) {
    self.clothing = clothing
  }

  var body: some View {
    VStack {
      if let uiImage = UIImage(data: clothing.clothingImage!) {
        Image(uiImage: uiImage)
          .resizable()
          .foregroundColor(.clear)
          .frame(width: 100, height: 140)
          .background(CustomColor.color1)
          .cornerRadius(CustomRadius.radius8)
      } else {
        Image("PATH_TO_IMAGE")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 140)
          .clipped()
      }
    }
  }
}

#Preview {
  ClothingItemView(of: Clothing(title: "Test", clothingImage: UIImage(systemName: "tshirt")!.jpegData(compressionQuality: 0.8)!, clothingType: .shirt, warmthLevel: .hot))
}
