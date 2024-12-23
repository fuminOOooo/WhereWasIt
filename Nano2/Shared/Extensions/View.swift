//
//  View.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

extension View {
    
    @ViewBuilder func conditionalPadding(
        _ edge: Edge.Set,
        on: Binding<Bool>
    ) -> some View {
        
        if on.wrappedValue {
            self
                .padding(edge)
        } else {
            self
        }
        
    }
    
}
