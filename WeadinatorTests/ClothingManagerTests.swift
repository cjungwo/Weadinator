//
//  ClothingManagerTests.swift
//  WeadinatorTests
//
//  Created by JungWoo Choi on 27/10/2024.
//

import Testing
@testable import Weadinator

@Suite("Clothing Manager Tests")
struct ClothingManagerTest {

  let sut: ClothingManager = ClothingManager()

  @Test("Successfully create new clothing")
  func whenCreatingNewClothing_thenCreatedNewClothingCorrectly() async throws {

    // when
    let createdClothing = sut.createNewClothing()

    // then
    #expect(createdClothing.clothingType == .jacket)
  }

  @Test("Matched type in title")
  func givenClothing_whenCheckingTypeInTitle_thenMatchedClothingTypeAndTypeInTitle() async throws {

    // given
    let testClothing: Clothing = Clothing()

    // when
    let isMatched = sut.checkTypeInTitle(clothing: testClothing)

    // then
    #expect(isMatched == true)
  }

  @Test("Unmatched type in title")
  func givenClothing_whenCheckingTypeInTitle_thenUnmatchedClothingTypeAndTypeInTitle() async throws {

    // given
    var testClothing: Clothing = Clothing()

    // when
    testClothing.clothingType = .shoes

    let isMatched = sut.checkTypeInTitle(clothing: testClothing)

    // then
    #expect(isMatched == false)
  }

  @Test("Successfully generate custom title")
  func givenClothing_whenGeneratingCustomTitle_thenGeneratedCustomTitle() async throws {

    // given
    let testClothing: Clothing = Clothing()

    // when
    let generatedTitle = sut.customTitle(clothing: testClothing)

    // then
    #expect(generatedTitle == "\(testClothing.clothingType)#\(testClothing.id)")
  }
}
