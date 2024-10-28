//
//  CoordinatorTests.swift
//  WeadinatorTests
//
//  Created by JungWoo Choi on 27/10/2024.
//

import Testing
@testable import Weadinator

@Suite("Coordinator Tests")
struct CoordinatorTests {

  let sut: Coordinator = Coordinator(tempHigh: 5, tempLow: 13, clothingList: MockData.clothingList)


  @Test("Return warmth level from avg temp") func givenNothing_whencalcWarmthLevel_thenReturnWarmthLevelCorrectly() async throws {
    // given
    let expected: WarmthLevel = .cool

    // when
    let result: WarmthLevel = sut.calcWarmthLevelFromTempAvg()

    // then
    #expect(result == expected)
  }

  @Test("Return warmth level from avg temp") func givenWarmthLevel_whencalcWarmthLevel_thenReturnWarmthLevelCorrectly() async throws {
    // given
    let expected: WarmthLevel = .cool

    // when
    let result: WarmthLevel = sut.calcWarmthLevelFromTempAvg()

    // then
    #expect(result == expected)
  }

}
