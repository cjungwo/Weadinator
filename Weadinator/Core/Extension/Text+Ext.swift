//
//  Text+Ext.swift
//  Weadinator
//
//  Created by JungWoo Choi on 23/10/2024.
//

import SwiftUI

extension Text {
  var title2Text: some View {
    self
    .font(.system(size: 24, weight: .medium))
  }

  var title3Text: some View {
    self
    .font(.system(size: 22, weight: .medium))
  }

  var labelText: some View {
    self
      .font(.system(size: 18, weight: .bold))
  }

  var btnText: some View {
    self
      .font(.system(size: 16, weight: .medium))
  }
}
