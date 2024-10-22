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
        clothingColor: .blue
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

    let mockWeatherItems: [Weather] = [
      .init(
        date: Date(),
        location: CLLocation(latitude: 37.7749, longitude: -122.4194), // San Francisco
        temperatureHigh: 22.0,
        temperatureLow: 15.0,
        condition: .sunny,
        precipitation: 0.0
      ),
      .init(
        date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        location: CLLocation(latitude: 34.0522, longitude: -118.2437), // Los Angeles
        temperatureHigh: 25.0,
        temperatureLow: 18.0,
        condition: .cloudy,
        precipitation: 0.1
      ),
      .init(
        date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
        location: CLLocation(latitude: 40.7128, longitude: -74.0060), // New York
        temperatureHigh: 28.0,
        temperatureLow: 20.0,
        condition: .rainy,
        precipitation: 10.0
      )
    ]

    for item in mockClothingItems {
      context.insert(item)
    }

    for item in mockWeatherItems {
      context.insert(item)
    }
  }
}
