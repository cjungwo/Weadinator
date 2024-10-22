//
//  Clothing.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import SwiftData

@Model
class Clothing {
  #Unique<Clothing>([\.id])

  var id: UUID
  var title: String

  var clothingImage: Data?
  var clothingType: ClothingType
  var warmthLevel: WarmthLevel
  var clothingColor: String

  init(
    id: UUID = .init(),
    title: String = "",
    clothingImage: Data? = nil,
    clothingType: ClothingType = .shirt,
    warmthLevel: WarmthLevel = .moderate,
    clothingColor: String = "black"
  ) {
    self.id = id
    self.title = title
    self.clothingType = clothingType
    self.warmthLevel = warmthLevel
    self.clothingColor = clothingColor.description
  }

  convenience init(
    title: String,
    clothingType: ClothingType,
    warmthLevel: WarmthLevel,
    clothingColor: Color
  ) {
    self.init(title: title, clothingType: clothingType, warmthLevel: warmthLevel, clothingColor: clothingColor.description)
  }
}
