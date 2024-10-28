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


  @Test("Return warmth level from temp avg") func givenNothing_whenCalcWarmthLevelByTempAvg_thenReturnWarmthLevelCorrectly() async throws {
    // given
    let expected: WarmthLevel = .cool

    // when
    let result: WarmthLevel = sut.calcWarmthLevelFromTempAvg()

    // then
    #expect(result == expected)
  }

  @Test("Filtering clothng list by warmth level") func givenWarmthLevel_whenFilterClothingListByWarmthLevel_thenReturnNewList() async throws {
    // given
    let warmthLevel: WarmthLevel = .cool

    // when
    let newList: [Clothing] = sut.filterClothingListByWarmthLevel(clothingList: MockData.clothingList, warmthLevel: .cool)

    // then
    #expect((newList.first?.warmthLevel ?? .cool) == warmthLevel)
    #expect((newList.last?.warmthLevel ?? .cool) == warmthLevel)
  }

  @Test("Filtering clothng list by clothing type") func givenClothingType_whenFilterClothingListByClothingType_thenReturnNewList() async throws {
    // given
    let clothingType: ClothingType = .shoes

    // when
    let newList: [Clothing] = sut.filterClothingListByClothingType(.shoes, from: MockData.clothingList)

    // then
    #expect((newList.first?.clothingType ?? .shoes) == clothingType)
    #expect((newList.last?.clothingType ?? .shoes) == clothingType)
  }

  @Test("Get random clothing successfully") func givenClothingListAndClothingType_whenGetRandomClothing_thenReturnRandomClothing() async throws {
    // given
    let clothingType: ClothingType = .shoes

    // when
    let randomClothing: Clothing? = sut.getRandomClothing(clothingList: MockData.clothingList, clothingType: clothingType)

    // then
    #expect(randomClothing?.clothingType ?? .shoes == clothingType)
  }

  @Test("Generate style successfully") func givenNothing_whenGenerateStyle_thenReturnClothingListAsStyle() async throws {
    // given

    // when
    let style: [Clothing?] = sut.generateStyle()

    // then
    #expect(style.count == ClothingType.allCases.count)
  }

  @Test("Generate style list successfully") func givenNothing_whenGenerateStyleList_thenReturnStyleList() async throws {
    // given

    // when
    let styleList: [[Clothing?]] = sut.generateStyleList()

    // then
    #expect(styleList.count == 4)
    #expect(styleList.first?.count == 5)
  }


}
