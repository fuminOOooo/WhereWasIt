//
//  PeekDetentView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI

struct DetentView: View {
    
    public init(
        settingsButtonAction: @escaping (() -> Void),
        pinButtonAction: @escaping (() -> Void),
        archivesButtonAction: @escaping (() -> Void),
        onNavigationDismiss: @escaping (() -> Void)
    ) {
        self.settingsButtonAction = settingsButtonAction
        self.pinButtonAction = pinButtonAction
        self.archivesButtonAction = archivesButtonAction
        self.onNavigationDismiss = onNavigationDismiss
    }
    
    let settingsButtonAction: (() -> Void)
    let pinButtonAction: (() -> Void)
    let archivesButtonAction: (() -> Void)
    let onNavigationDismiss: (() -> Void)
    
        
    var body: some View {
        
        HStack {
            
                        
        }
        .padding([.horizontal, .bottom])
        
    }
    
}
