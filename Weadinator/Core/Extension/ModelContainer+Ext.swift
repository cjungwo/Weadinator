//
//  ModelContainer+Ext.swift
//  Weadinator
//
//  Created by JungWoo Choi on 22/10/2024.
//

import Foundation
import SwiftData

extension ModelContainer {
    static let mock: ModelContainer = {
        let schema = Schema([Clothing.self])
        return try! ModelContainer(for: schema)
    }()
}
