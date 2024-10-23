//
//  Weather.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import Foundation
import CoreLocation



struct Weather: Codable {
    var date: Date
    var longitude: Double
    var latitude: Double
    var currentTemp: Double
    var temperatureHigh: Double
    var temperatureLow: Double
    var condition: WeatherCondition
    var precipitation: Double
}
