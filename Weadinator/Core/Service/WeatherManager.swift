//
//  WeatherManager.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
    @Published var weather: Weather?
    
    let apiKey = "57bf91753b44ef1e64d8d0d7e2328422"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for location: CLLocation) async {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        guard let url = URL(string: "\(baseURL)?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)") else {
            print("Invalide URL")
            return
        }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            
            guard let main = json?["main"] as? [String: Any],
                  let currentTemp = main["temp"] as? Double,
                  let tempHigh = main["temp_max"] as? Double,
                  let tempLow = main["temp_min"] as? Double,
                  let weatherArray = json?["weather"] as? [[String: Any]],
                  let firstWeather = weatherArray.first,
                  let weatherMain = firstWeather["main"] as? String,
                  let weatherDescription = firstWeather["description"] as? String,
                  let weatherIconCode = firstWeather["icon"] as? String else {
                print("JSON parsing failed")
                return
            }
            
            let precipitation = (json?["rain"] as? [String: Double])?["1h"] ?? 0.0
            
            let condition = WeatherCondition(rawValue: weatherMain.lowercased()) ?? .clear
            
            let fetchedWeather = Weather(
                date: Date(),
                longitude: longitude,
                latitude: latitude,
                currentTemp: currentTemp,
                temperatureHigh: tempHigh,
                temperatureLow: tempLow,
                condition: condition,
                precipitation: precipitation,
                description: weatherDescription,
                iconCode: weatherIconCode
            )
            DispatchQueue.main.async {
                self.weather = fetchedWeather
            }
        } catch {
            print("Failed to fetch weather: \(error)")
        }
    }
}
