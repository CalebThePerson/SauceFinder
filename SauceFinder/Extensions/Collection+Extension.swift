//
//  Collection+Extension.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/12/21.
//

import SwiftUI

//Help to preventing delete row from index out of bounds.
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
