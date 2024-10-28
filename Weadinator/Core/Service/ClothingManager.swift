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

    clothing.title = title != "" ? title : customTitle(clothing: clothing)
    clothing.clothingImage = selectedImageData
    clothing.clothingColor = clothingColor
    clothing.clothingType = clothingType
    clothing.warmthLevel = warmthLevel

    print("DEBUG: create new clothing model: \(clothing)")
    return clothing
  }

  func checkTypeInTitle(clothing: Clothing) -> Bool {
    if let hashIndex = clothing.title.firstIndex(of: "#") {
      let substring = clothing.title[..<hashIndex]
      let result = String(substring)
      if result != clothing.clothingType.rawValue {
        print("DEBUG: default title does not match clothing type")
        return false
      }
    }
    return true
  }

  func customTitle(clothing: Clothing) -> String {
    return "\(clothing.clothingType)#\(clothing.id)"
  }
}
