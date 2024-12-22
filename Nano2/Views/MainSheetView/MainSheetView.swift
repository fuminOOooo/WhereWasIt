//
//  MainSheetView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI

struct MainSheetView: View {
    
    @FetchRequest(sortDescriptors: []) var locationitems: FetchedResults<LocationItem>
    @Environment(\.managedObjectContext) private var viewContext
    @State private var expanded = false
    @StateObject var vm : MainSheetViewModel = MainSheetViewModel()
    @State private var detents : Set<PresentationDetent> = [.small]
    @State private var currentDetent : PresentationDetent = .small
    @State private var saveLocation : Bool = false
    @State private var currentDetails : CurrentView = .none
    
    private func expandDetent() {
        detents.insert(.large)
        currentDetent = .large
    }
    
    private func shrinkDetent() {
        detents.insert(.small)
        currentDetent = .small
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                  
                if expanded {
                    
                    details
                    
                    
                } else {
                    
                    buttons
                    
                }
                
            }
            
        }
        .mainSheetViewModified()
        .animation(.easeInOut, value: expanded)
        .presentationDetents(detents, selection: $currentDetent)
        .presentationCornerRadius(NumberConstant.defaultCornerRadiusSize)
        .onChange(of: currentDetent, {
            onDetentChange()
        })
        .alert(
            StringConstant.saveLocationAlertViewText1,
            isPresented: $saveLocation
        ) {
            
            alert
            
        }
        
    }
    
}

private extension MainSheetView {
    
    enum CurrentView {
        case settings
        case archives
        case none
    }
    
    private func onDetentChange() {
        
        Task {
            
            await MainActor.run {
                switch currentDetent {
                case .small:
                    expanded = false
                    detents.remove(.large)
                case .large:
                    expanded = true
                    detents.remove(.small)
                default: break
                }
            }
            
        }

    }
    
    @ViewBuilder private var details: some View {
        switch currentDetails {
        case .settings:
            SettingsView(
                onDismiss: shrinkDetent
            )
        case .archives:
            ArchivesView(
                onDismiss: shrinkDetent,
                emptyAction: shrinkDetent
            )
        case .none:
            VStack{}
        }
    }
    
    @ViewBuilder private var buttons: some View {
        ThreeButtonView(
            locationsCount: locationitems.count,
            settingsColor: .gray,
            settingsButtonAction: {
                expandDetent()
                currentDetails = .settings
            },
            saveColor: .red,
            saveButtonAction: {
                saveLocation.toggle()
            },
            archivesColor: .gray,
            archivesButtonAction: {
                expandDetent()
                currentDetails = .archives
            }
        )
    }
    
    @ViewBuilder private var alert: some View {
        
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
