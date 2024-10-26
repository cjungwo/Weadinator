//
//  PreviewHelper.swift
//  Weadinator
//
//  Created by JungWoo Choi on 22/10/2024.
//

import SwiftUI
import SwiftData
import CoreLocation

class PreviewHelper {
  static func mockImageData() -> Data {
    return UIImage(systemName: "tshirt")!.jpegData(compressionQuality: 0.8)!
  }

  static func addMockData(context: ModelContext) {
    let mockClothingItems: [Clothing] = [
      .init(
        title: "Warm Jacket",
        clothingImage: mockImageData(),
        clothingType: .jacket,
        warmthLevel: .cool,
        clothingColor: .beige
      ),
      .init(
        title: "T-Shirt",
        clothingImage: mockImageData(),
        clothingType: .shirt,
        warmthLevel: .hot,
        clothingColor: .white
      ),
      .init(
        title: "Sweater",
        clothingImage: mockImageData(),
        clothingType: .jacket,
        warmthLevel: .cold,
        clothingColor: .gray
      ),
      .init(
        title: "Jeans",
        clothingImage: mockImageData(),
        clothingType: .trousers,
        warmthLevel: .moderate,
        clothingColor: .blue
      )

    ]

    for item in mockClothingItems {
      context.insert(item)
    }
  }
}
