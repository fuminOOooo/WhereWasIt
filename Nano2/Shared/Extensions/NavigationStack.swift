//
//  NavigationView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI

extension NavigationStack {
    
    func mainSheetViewModified() -> some View {
        
        self
            .padding(.top)
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled(upThrough: .small))
            .presentationDragIndicator(Visibility.hidden)
        
    }
    
}
