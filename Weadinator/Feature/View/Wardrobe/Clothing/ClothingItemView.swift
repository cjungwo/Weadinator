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
            if let uiImage = UIImage(data: clothing.clothingImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
            }

            Text(clothing.title)
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
  ClothingItemView(of: Clothing(title: "Test", clothingImage: UIImage(systemName: "tshirt")!.jpegData(compressionQuality: 0.8)!, clothingType: .shirt, warmthLevel: .hot))
}
