//
//  CustomButton.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.
//

import SwiftUI

struct FillButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("SF-Pro-Rounded-Regular", size: 16))
            .padding()
            .frame(height: 44)
            .background(configuration.isPressed ? Color.gray : Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(configuration.isPressed ? Color.gray : Color.black)
            )
            .cornerRadius(6)
            .foregroundColor(configuration.isPressed ? Color.white : Color.white)
    }
}

struct BorderButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Fredoka-Medium", size: 16))
            .padding()
            .frame(height: 44)
            .background(configuration.isPressed ? Color.gray : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(configuration.isPressed ? Color.gray : Color.gray)
            )
            .cornerRadius(6)
            .foregroundColor(configuration.isPressed ? Color.gray : Color.gray)
    }
}
