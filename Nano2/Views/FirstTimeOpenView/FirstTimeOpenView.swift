//
//  FirstTimeOpenView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI

struct FirstTimeOpenView: View {
    
    public init (
        vm: FirstTimeOpenViewModel = FirstTimeOpenViewModel(),
        sheetVisibility: Binding<Bool>
    ) {
        self.vm = vm
        self._sheetVisibility = sheetVisibility
    }
    
    @ObservedObject var vm : FirstTimeOpenViewModel
    @Binding var sheetVisibility : Bool
    
    var body: some View {
        
        if (vm.notOpenedBefore) {
            
            MiddlePopupView(
                
                shown: $vm.notOpenedBefore,
                buttonText: StringConstant.mainViewText1,
                buttonAction: {
                    vm.setFirstTime()
                    sheetVisibility.toggle()
                }
                
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
    
    @Previewable @State var visibility: Bool = true
    
    FirstTimeOpenView(sheetVisibility: $visibility)
    
}
