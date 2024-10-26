//
//  WeatherCondition.swift
//  Weadinator
//
//  Created by 조성하 on 18/10/2024.
//

import Foundation

enum WeatherCondition: String, Codable {
  case clear
  case cloudy
  case rainy
  case snow
  case thunder

  var iconName: String {
    switch self {
    case .clear: return "sun"
    case .cloudy: return "cloud"
    case .rainy: return "rain"
    case .snow: return "snow"
    case .thunder: return "thunder"
    }
  }

  var description: String {
    switch self {
    case .clear: return "Clear"
    case .cloudy: return "Cloudy"
    case .rainy: return "Rainy"
    case .snow: return "Snow"
    case .thunder: return "Thunder"
    }
  }
}
