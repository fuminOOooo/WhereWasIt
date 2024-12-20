//
//  MainSheetView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//


import SwiftUI

struct MainSheetView: View {
    
    @State private var expanded = false
    @StateObject var vm : MainSheetViewModel = MainSheetViewModel()
    @State private var currentDetent : PresentationDetent = SheetSizes.peek.detent
    
    var body: some View {
        
        VStack {
            
            if expanded {
                
                Text("NOT SHOWING buttons")
                    .font(.title2)
                    .bold()
                // TODO: Add actions view when sheet is expanded
                
            } else {
                
                Text("SHOWING buttons")
                    .font(.title2)
                    .bold()
                // TODO: Add functionality to check saved locations
                
                PeekDetentView(
                    settingsButtonAction: {
                        
                    },
                    pinButtonAction: {
                        
                    },
                    archivesButtonAction: {
                        
                    }
                )
                
            }
            
        }
        .animation(.easeInOut, value: expanded)
        .padding(.top)
        .presentationDetents(SheetSizes.detents, selection: $currentDetent)
        .presentationBackgroundInteraction(.enabled(upThrough: SheetSizes.peek.detent))
        .presentationDragIndicator(Visibility.hidden)
        .presentationCornerRadius(NumberConstant.defaultCornerRadiusSize)
        .interactiveDismissDisabled()
        .onChange(of: currentDetent, {
            
            Task {
                
                await MainActor.run {
                    switch currentDetent {
                    case SheetSizes.peek.detent:
                        expanded = false
                    case SheetSizes.detailed.detent:
                        expanded = true
                    default: break
                    }
                }
                
            }
            
        })
        
    }
    
}

#Preview {
    
    @Previewable @State var sheetOpened: Bool = true
    
    VStack{}
        .sheet(
            isPresented: $sheetOpened
        ) {
            MainSheetView()
        }
    
}
