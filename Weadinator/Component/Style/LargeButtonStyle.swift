//
//  LargeButtonStyle.swift
//  Weadinator
//
//  Created by JungWoo Choi on 25/10/2024.
//

import SwiftUI

struct LargeButtonStyle: View {
  var title: String
  var bgColor: Color = CustomColor.bgColor
  var fgColor: Color = .white
  var action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Text(title)
          .btnText
          .foregroundStyle(fgColor)
      }
        .padding(CustomPadding.padding16)
        .hSpacing(.center)
        .background(bgColor)
        .cornerRadius(CustomRadius.radius8)
    }
  }
}
