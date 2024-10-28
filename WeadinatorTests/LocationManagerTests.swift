//
//  Test.swift
//  WeadinatorTests
//
//  Created by 조성하 on 28/10/2024.
//

import Testing
@testable import Weadinator
import CoreLocation


@Suite("Location Manager Tests")
struct LocationManagerTests {

    let sut: LocationManager = LocationManager()
    
    @Test("Successfully update location name")
    func givenLocation_whenUpdatingLocationName_thenUpdatedLocationName() async throws {
        
        //given
        let location = CLLocation(latitude: 37.5503, longitude: 126.9971)
        
        
        //when
        sut.updateLocationName(from: location)
        
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        //then
        #expect(sut.locationName == "Seoul")
    }

}
