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
        textInput: Binding<String> = .constant(String()),
        cancelText: String = StringConstant.cancelAlertViewText,
        cancelRole: ButtonRole? = .cancel,
        cancelAction: (() -> Void)? = nil,
        buttonText: String = StringConstant.saveAlertViewText,
        buttonRole: ButtonRole? = nil,
        buttonAction: @escaping () -> Void
    ) {
        self.placeholder = placeholder
        self._textInput = textInput
        self.cancelText = cancelText
        self.cancelRole = cancelRole
        self.cancelAction = cancelAction
        self.buttonText = buttonText
        self.buttonRole = buttonRole
        self.buttonAction = buttonAction
    }
    
    private let placeholder : String
    @Binding private var textInput : String
    
    private let cancelText : String
    private let cancelRole : ButtonRole?
    private let cancelAction : (() -> Void)?

    private let buttonText : String
    private let buttonRole : ButtonRole?
    private let buttonAction : (() -> Void)
    
    var body: some View {
        
        if (placeholder != String()) {
            TextField(
                placeholder,
                text: $textInput
            )
        }
        
        Button(
            cancelText,
            role: cancelRole
        ) {
            guard let action = cancelAction else { return }
            action()
        }
        
        Button(
            buttonText,
            role: buttonRole
        ) {
            buttonAction()
        }
        .disabled(!(placeholder == String()) && textInput == String())
        
    }
    
}
