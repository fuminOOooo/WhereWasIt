//
//  FirstTimeModal.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.

import SwiftUI

struct MiddlePopupView<Content: View>: View {
    
    public init (
        shown: Binding<Bool>,
        buttonText: String,
        buttonAction: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self._shown = shown
        self.buttonText = buttonText
        self.buttonAction = buttonAction
        self.content = content()
    }
    
    @Binding var shown: Bool
    
    let buttonText : String
    
    let buttonAction : (() -> Void)?
    
    @ViewBuilder let content: Content
    
    var body: some View {
        
        if shown {
            
            ZStack {
                
                Color.black.opacity(NumberConstant.defaultDimmedBackgroundOpacity)
                
                VStack {
                    
                    content
                    
                    Button {
                        
                        shown.toggle()
                        
                        if let buttonAction = buttonAction {
                            buttonAction()
                        }
                        
                    } label: {
                        
                        Text(buttonText)
                        
                    }
                    .withFillButtonStyle()
                    
                }
                .padding()
                .background(CustomColor.darkGray)
                .cornerRadius(NumberConstant.defaultCornerRadiusSize)
                .padding()
                
            }
            
            
        }
        
    }
    
}

#Preview {
    
    @Previewable @State var shown: Bool = true
    
    ZStack {
        
        Color.green
        
        MiddlePopupView(
            shown: $shown,
            buttonText: "Preview Button"
        ) { } content: { Text("Preview Text") }
        
        
    }
    
}
