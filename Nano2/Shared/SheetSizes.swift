//
//  SheetSizes.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import Foundation
import SwiftUI

enum SheetSizes: CGFloat, CaseIterable {
    
    case peek = 0.26
    case detailed = 1

    var detent: PresentationDetent {
        .fraction(rawValue)
    }

    static let detents = Set(SheetSizes.allCases.map { $0.detent })
    
}
