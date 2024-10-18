//
//  Clothing.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import Foundation

class Clothing: Codable {
  let id: String
  let name: String
  let image: URL
  let clothingType: ClothingType
  var warmthLevel: WarmthLevel
  let color: String
}
