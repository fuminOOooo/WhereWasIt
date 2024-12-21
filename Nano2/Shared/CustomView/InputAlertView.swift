//
//  InputAlertView.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

struct InputAlertView: View {
    
    public init (
        placeholder: String = String(),
        textInput: Binding<String>,
        cancelText: String = StringConstant.cancelAlertViewText,
        cancelAction: (() -> Void)? = nil,
        buttonText: String = StringConstant.saveAlertViewText,
        buttonAction: @escaping () -> Void
    ) {
        self.placeholder = placeholder
        self._textInput = textInput
        self.cancelText = cancelText
        self.cancelAction = cancelAction
        self.buttonText = buttonText
        self.buttonAction = buttonAction
    }
    
    private let placeholder : String
    @Binding private var textInput : String
    
    private let cancelText : String
    private let cancelAction : (() -> Void)?
    
    private let buttonText : String
    private let buttonAction : (() -> Void)
    
    var body: some View {
        
        TextField(
            placeholder,
            text: $textInput
        )
        
        Button(
            cancelText
        ) {
            guard let action = cancelAction else { return }
            action()
        }
        
        Button(
            buttonText
        ) {
            buttonAction()
        }
        .disabled(textInput == String())
        
    }
    
}
