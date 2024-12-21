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
        settingsButtonAction: @escaping () -> Void,
        saveButtonAction: @escaping () -> Void,
        archivesButtonAction: @escaping () -> Void
    ) {
        self.locationsCount = locationsCount
        self.settingsButtonAction = settingsButtonAction
        self.saveButtonAction = saveButtonAction
        self.archivesButtonAction = archivesButtonAction
    }
    
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
                
                SystemImageButton(
                    StringConstant.pinButtonText,
                    imageName: ImageNameConstant.pinButtonImage
                ) {
                    saveButtonAction()
                }
                
                SystemImageButton(
                    StringConstant.listButtonText,
                    imageName: ImageNameConstant.listButtonImage
                ) {
                    archivesButtonAction()
                }
                
            }
            .padding([.horizontal, .bottom])
            
        }
    }
}
