//
//  MainSheetView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//


import SwiftUI

struct MainSheetView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var expanded = false
    @StateObject var vm : MainSheetViewModel = MainSheetViewModel()
    @State private var currentDetent : PresentationDetent = SheetSizes.peek.detent
    @State private var saveLocation : Bool = false
    
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
                        saveLocation.toggle()
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
        .alert(
            StringConstant.saveLocationAlertViewText1,
            isPresented: $saveLocation
        ) {
            
            InputAlertView(
                placeholder: StringConstant.saveLocationAlertViewText2,
                textInput: $vm.savedLocationName,
                cancelAction: {
                    saveLocation = false
                },
                buttonAction: {
                    vm.saveCurrentLocation(context: viewContext)
                }
            )
            
        }
        
    }
    
}
