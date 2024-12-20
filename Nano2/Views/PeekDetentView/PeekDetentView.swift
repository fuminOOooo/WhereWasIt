//
//  PeekDetentView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI

struct PeekDetentView: View {
    
    public init(
        settingsButtonAction: @escaping (() -> Void),
        pinButtonAction: @escaping (() -> Void),
        archivesButtonAction: @escaping (() -> Void)
    ) {
        self.settingsButtonAction = settingsButtonAction
        self.pinButtonAction = pinButtonAction
        self.archivesButtonAction = archivesButtonAction
    }
    
    let settingsButtonAction: (() -> Void)
    let pinButtonAction: (() -> Void)
    let archivesButtonAction: (() -> Void)
    
    @ViewBuilder
    func oneButton(_ text: String, imageName: String, _ action: @escaping (() -> Void)) -> some View {
        
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
    
    var body: some View {
        
        HStack {
            
            oneButton(
                StringConstant.settingsButtonText,
                imageName: ImageNameConstant.settingsButtonImage
            ) {
                settingsButtonAction()
            }
            
            oneButton(
                StringConstant.pinButtonText,
                imageName: ImageNameConstant.pinButtonImage
            ) {
                pinButtonAction()
            }
            
            oneButton(
                StringConstant.listButtonText,
                imageName: ImageNameConstant.listButtonImage
            ) {
                archivesButtonAction()
            }
            
        }
        .padding([.horizontal, .bottom])
        
    }
    
}
