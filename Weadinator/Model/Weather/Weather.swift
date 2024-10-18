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
    var location: CLLocation
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
        self.location = location
        self.temperatureHigh = temperatureHigh
        self.temperatureLow = temperatureLow
        self.condition = condition
        self.precipitation = precipitation
    }
}
