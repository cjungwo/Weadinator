//
//  WarmthLevel.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import Foundation

enum WarmthLevel: String, Codable {
  case cold
  case cool
  case moderate
  case warm
  case hot

  var compareTemperature: Double {
    switch self {
    case .cold: return 0
    case .cool: return 10
    case .moderate: return 20
    case .warm: return 30
    case .hot: return 40
    }
  }
}
