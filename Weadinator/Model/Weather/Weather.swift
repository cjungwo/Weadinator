//
//  Weather.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import Foundation
import CoreLocation
import SwiftData

@Model
class Weather {
  #Unique<Weather>([\.date])

  var date: Date
  var longitube: Double
  var latitube: Double
  var temperatureHigh: Double
  var temperatureLow: Double
  var condition: WeatherCondition
  var precipitation: Double

  init(
    date: Date,
    location: CLLocation,
    temperatureHigh: Double,
    temperatureLow: Double,
    condition: WeatherCondition,
    precipitation: Double
  ) {
    self.date = date
    self.longitube = location.coordinate.longitude
    self.latitube = location.coordinate.latitude
    self.temperatureHigh = temperatureHigh
    self.temperatureLow = temperatureLow
    self.condition = condition
    self.precipitation = precipitation
  }
}
