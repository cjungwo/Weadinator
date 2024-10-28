//
//  WeatherManagerTests.swift
//  WeadinatorTests
//
//  Created by 조성하 on 28/10/2024.
//

import Testing
@testable import Weadinator
import CoreLocation

@Suite("Weather Manager Tests")
struct WeatherManagerTests {

    let sut: WeatherManager = WeatherManager()
    
    @Test("Successfully fetch weather")
    func givenLocation_whenFetchWeather_thenUpdatedWeather() async throws {
        
        //given
        let location = CLLocation(latitude: 37.5503, longitude: 126.9971)
        
        //when
        await sut.fetchWeather(for: location)
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        
        //then
        #expect(sut.weather != nil)
    }
    
}
