//
//  SettingsView.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }
    
    private let onDismiss : (() -> Void)
    
    var body: some View {
        
        VStack {
            Text(StringConstant.settingsButtonText)
        }
        .useCustomToolbar(
            onDismiss: {
                onDismiss()
                presentationMode.wrappedValue.dismiss()
            }
        )
        
    }
    
}
