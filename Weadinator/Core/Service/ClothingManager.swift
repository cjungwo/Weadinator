//
//  ClothingManager.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import PhotosUI

class ClothingManager: ObservableObject {
  @Published var selectedImage: PhotosPickerItem?
  @Published var selectedImageData: Data? = nil
  @Published var title: String = ""
  @Published var clothingColor: ClothingColor = .black
  @Published var clothingType: ClothingType = .jacket
  @Published var warmthLevel: WarmthLevel = .hot

  func createNewClothing() -> Clothing {
    let clothing = Clothing()

    clothing.title = title
    clothing.clothingImage = selectedImageData
    clothing.clothingColor = clothingColor
    clothing.clothingType = clothingType
    clothing.warmthLevel = warmthLevel

    return clothing
  }
}
