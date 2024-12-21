//
//  CustomButton.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.
//

import SwiftUI

extension View {
    
    func withFillButtonStyle() -> some View {
        buttonStyle(FillButton())
    }
    
    func withBorderButtonStyle() -> some View {
        buttonStyle(BorderButton())
    }
    
}

struct FillButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(CustomFont.roundedRegular16)
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: NumberConstant.defaultCornerRadiusSize)
                    .stroke(configuration.isPressed ? Color.gray : Color.black)
            )
            .cornerRadius(NumberConstant.defaultCornerRadiusSize)
            .foregroundColor(configuration.isPressed ? Color.white : Color.white)
    }
    
}

struct BorderButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(CustomFont.medium16)
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: NumberConstant.defaultCornerRadiusSize)
                    .stroke(configuration.isPressed ? Color.gray : Color.gray)
            )
            .cornerRadius(NumberConstant.defaultCornerRadiusSize)
            .foregroundColor(configuration.isPressed ? Color.gray : Color.gray)
    }
    
}
