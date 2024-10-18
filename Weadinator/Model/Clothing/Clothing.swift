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
  var clothingImage: URL
  var clothingType: ClothingType
  var warmthLevel: WarmthLevel
  var clothingColor: Color

  init(
    id: UUID = .init(),
    title: String?,
    clothingImage: URL,
    clothingType: ClothingType,
    warmthLevel: WarmthLevel,
    clothingColor: Color = .black
  ) {
    self.id = id
    self.title = title ?? clothingType.rawValue + id.uuidString
    self.clothingImage = clothingImage
    self.clothingType = clothingType
    self.warmthLevel = warmthLevel
    self.clothingColor = clothingColor
  }
}
