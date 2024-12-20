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
                // TODO: Add actions view when sheet is expanded
                
            } else {
                
                Text("SHOWING buttons")
                // TODO: Add actions view when sheet is not expanded
                
            }
            
        }
        .animation(.easeInOut, value: expanded)
        .presentationDetents(SheetSizes.detents, selection: $currentDetent)
        .presentationBackgroundInteraction(.enabled(upThrough: SheetSizes.peek.detent))
        .presentationDragIndicator(Visibility.hidden)
        .presentationCornerRadius(NumberConstant.defaultCornerRadiusSize)
        .interactiveDismissDisabled()
        .onChange(of: currentDetent, {
            
            Task {
                
                try? await Task.sleep(for: .milliseconds(NumberConstant.defaultAnimationSleepMillisecondValue))
                
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
