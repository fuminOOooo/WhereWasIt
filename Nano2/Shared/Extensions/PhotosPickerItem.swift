//
//  PhotosPickerItem.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI
import PhotosUI

extension PhotosPickerItem {
    
    var identifier: String {
        guard let identifier = itemIdentifier else {
            fatalError(StringConstant.noLibrary)
        }
        return identifier
    }
    
}
