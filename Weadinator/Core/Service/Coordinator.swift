//
//  Coordinator.swift
//  Weadinator
//
//  Created by JungWoo Choi on 26/10/2024.
//

import Foundation

class Coordinator: ObservableObject {
  let tempHigh: Double
  let tempLow: Double
  let clothingList: [Clothing]

  var tempAvg: Double {
    (tempHigh + tempLow)/2
  }

  init(
    tempHigh: Double,
    tempLow: Double,
    clothingList: [Clothing]
  ) {
    self.tempHigh = tempHigh
    self.tempLow = tempLow
    self.clothingList = clothingList
  }

  func calcWarmthLevelFromTempAvg() -> WarmthLevel {
    var warmthLevel: WarmthLevel = .cold

    switch tempAvg {
    case ..<0:
      warmthLevel = WarmthLevel.cold
    case 0..<10:
      warmthLevel = WarmthLevel.cool
    case 10..<20:
      warmthLevel = WarmthLevel.moderate
    case 20..<30:
      warmthLevel = WarmthLevel.warm
    case 30...:
      warmthLevel = WarmthLevel.hot
    default:
      warmthLevel = WarmthLevel.cold
    }

    print("DEBUG: TempAvg - \(tempAvg), WarmthLevel - \(warmthLevel.rawValue)")

    return warmthLevel
  }

  func filterClothingListByWarmthLevel(clothingList: [Clothing], warmthLevel: WarmthLevel) -> [Clothing] {
    var newList = [Clothing]()

    newList = clothingList.filter { $0.warmthLevel == warmthLevel }

    print("DEBUG: Filtered Clothing List - \(newList.count)")

    return newList
  }

  func filterClothingListByClothingType(_ clothingType: ClothingType, from clothingList: [Clothing]) -> [Clothing] {
    var newList = [Clothing]()

    newList = clothingList.filter { $0.clothingType == clothingType }

    print("DEBUG: Filtered Clothing List - \(newList.count)")

    return newList
  }

  func getRandomClothing(clothingList: [Clothing], clothingType: ClothingType) -> Clothing? {
    let filteredListByWarmthLevel = filterClothingListByWarmthLevel(clothingList: clothingList, warmthLevel: calcWarmthLevelFromTempAvg())
    let filteredListByClothingType = filterClothingListByClothingType(clothingType, from: filteredListByWarmthLevel)

    let randomClothing: Clothing? = filteredListByClothingType.randomElement()

    print("DEBUG: Random Clothing - \(randomClothing?.title ?? "Nil")")

    return randomClothing
  }

  func generateStyle() -> [Clothing?] {
    var newClothingList = [Clothing?]() // ClothingList [Jacket, Shirt, Trousers, ... ] -> Style

    for type in ClothingType.allCases {
      newClothingList.append(getRandomClothing(clothingList: self.clothingList, clothingType: type))
    }

    print("DEBUG: Generated Style - New Clothing List - \(newClothingList.count) == Clothing Types - \(ClothingType.allCases.count)")

    return newClothingList
  }

  func generateStyleList() -> [[Clothing?]] {
    var newStyleList = [[Clothing?]]() // StyleSet List

    for _ in 0..<4 {
      newStyleList.append(generateStyle())
    }

    print("DEBUG: Generated Style List - \(newStyleList.count) == Style Sets - \(4)")

    return newStyleList
  }
}
