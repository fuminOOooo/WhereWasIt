//
//  ThreeButtonView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI

struct ThreeButtonView: View {
    
    public init(
        locationsCount: Int,
        settingsColor: Color = .primary,
        settingsButtonAction: @escaping () -> Void,
        saveColor: Color = .primary,
        saveButtonAction: @escaping () -> Void,
        archivesColor: Color = .primary,
        archivesButtonAction: @escaping () -> Void
    ) {
        self.locationsCount = locationsCount
        self.settingsButtonAction = settingsButtonAction
        self.saveButtonAction = saveButtonAction
        self.archivesButtonAction = archivesButtonAction
        self.settingsColor = settingsColor
        self.saveColor = saveColor
        self.archivesColor = archivesColor
    }
    
    private let settingsColor: Color
    private let saveColor: Color
    private let archivesColor: Color
    
    private let locationsCount : Int
    private let settingsButtonAction : (() -> Void)
    private let saveButtonAction : (() -> Void)
    private let archivesButtonAction : (() -> Void)
    
    var body: some View {
        
        VStack {
            
            Text(String(locationsCount) + StringConstant.space + StringConstant.locationsSaved)
                .font(.title2)
                .bold()
            
            HStack {
                
                SystemImageButton(
                    StringConstant.settingsButtonText,
                    imageName: ImageNameConstant.settingsButtonImage
                ) {
                    settingsButtonAction()
                }
                .tint(settingsColor)
                
                SystemImageButton(
                    StringConstant.pinButtonText,
                    imageName: ImageNameConstant.pinButtonImage
                ) {
                    saveButtonAction()
                }
                .tint(saveColor)
                
                SystemImageButton(
                    StringConstant.listButtonText,
                    imageName: ImageNameConstant.listCircleImage
                ) {
                    archivesButtonAction()
                }
                .tint(archivesColor)
                
            }
            .padding([.horizontal, .bottom])
            
        }
    }
}
