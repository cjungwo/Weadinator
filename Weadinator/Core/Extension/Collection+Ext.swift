//
//  Collection+Ext.swift
//  Weadinator
//
//  Created by 조성하 on 28/10/2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
