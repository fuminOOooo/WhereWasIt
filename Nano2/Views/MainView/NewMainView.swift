//
//  NewMainView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import SwiftUI

struct NewMainView: View {
    
    public init(vm: NewMainViewModel = NewMainViewModel()) {
        self.vm = vm
        self.notOpenedBefore = vm.firstTimeCheck()
    }
    
    @ObservedObject var vm : NewMainViewModel
    @State var notOpenedBefore : Bool
    
    
    var body: some View {
        
        ZStack {
            
            Color.green
            
            if notOpenedBefore {
                
                MiddlePopupView(
                    
                    shown: $notOpenedBefore,
                    buttonText: StringConstant.mainViewText1,
                    buttonAction: vm.setFirstTime
                    
                ) {
                    
                    VStack (alignment: .leading) {
                        
                        Text(StringConstant.mainViewText2)
                            .font(CustomFont.lightText14)
                        
                        Text(StringConstant.mainViewText3)
                            .font(CustomFont.expandedBold)
                        
                        Divider()
                            .overlay(Color.white)
                            .padding(.bottom)
                        
                        Text(
                            StringConstant.mainViewText4
                        )
                        .font(CustomFont.lightText17)
                        
                    }
                    .foregroundColor(Color.white)
                    .padding(.bottom)
                    
                }
                
            }
            
        }
        
    }
    
}
