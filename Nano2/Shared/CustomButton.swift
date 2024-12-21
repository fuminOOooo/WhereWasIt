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
    
    @ViewBuilder
    func useCustomToolbar(_ title: String = String(), onDismiss: @escaping (() -> Void)) -> some View {
        self
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        onDismiss()
                    } label: {
                        Image(systemName: ImageNameConstant.xmarkImage)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.primary)
                    }
                    Text(title)
                        .font(.title)
                        .bold()
                }
            }
    }
    
    @ViewBuilder
    func SystemImageButton(_ text: String, imageName: String, _ action: @escaping (() -> Void)) -> some View {
        
        Button {
            
            action()
            
        } label: {
            
            VStack {
                
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(text)
                    .font(CustomFont.lightText14)
                    .foregroundStyle(Color.primary)
                
            }
            
        }

    }
    
}

extension Button {
    
    
    
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
