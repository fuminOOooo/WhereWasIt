//
//  NavigationView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI

extension NavigationStack {
    
    func mainSheetViewModified<V:Equatable>(value: V) -> some View {
        
        self
            .animation(.easeInOut, value: value)
            .padding(.top)
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled(upThrough: .small))
            .presentationDragIndicator(Visibility.hidden)
            .presentationCornerRadius(NumberConstant.defaultCornerRadiusSize)
        
    }
    
}
