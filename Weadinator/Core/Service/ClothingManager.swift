//
//  ClothingManager.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import PhotosUI

class ClothingManager: ObservableObject {
  @Published var selectedImage: PhotosPickerItem?
  @Published var selectedImageData: Data?
  @Published var clothing = Clothing()
  @Published var title: String = ""

  func addBtnTapped() {
    
  }
}
