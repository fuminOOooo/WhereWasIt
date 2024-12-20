//
//  FirstTimeOpenView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI

struct FirstTimeOpenView: View {
    
    public init (
        vm: FirstTimeOpenViewModel = FirstTimeOpenViewModel()
    ) {
        self.vm = vm
        self.notOpenedBefore = vm.firstTimeCheck()
    }
    
    @ObservedObject var vm : FirstTimeOpenViewModel
    @State var notOpenedBefore : Bool
    
    var body: some View {
        
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

#Preview {
    
    FirstTimeOpenView()
    
}
