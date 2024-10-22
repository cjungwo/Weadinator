//
//  Image+Ext.swift
//  Weadinator
//
//  Created by JungWoo Choi on 21/10/2024.
//

import SwiftUI

extension Image {
  func clothingListImageModifier() -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 100, height: 140)
      .clipped()
      .background(.black)
      .cornerRadius(8)
  }
}
