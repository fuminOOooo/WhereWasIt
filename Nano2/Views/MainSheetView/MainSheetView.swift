//
//  MainSheetView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI

struct MainSheetView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var locationitems: FetchedResults<LocationItem>
    
    @StateObject var vm : MainSheetViewModel = MainSheetViewModel()
    
    @State private var detents : Set<PresentationDetent> = [.small]
    @State private var currentDetent : PresentationDetent = .small
    @State private var saveLocation : Bool = false
    @State private var currentDetails : CurrentView = .none
    @State private var expanded = false
    @State private var didAddNewLocation = false
    
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
        .mainSheetViewModified(value: expanded)
        .presentationDetents(detents, selection: $currentDetent)
        .onChange(of: currentDetent, onDetentChange)
        
    }
    
}

private extension MainSheetView {
    
    enum CurrentView {
        case settings
        case archives
        case none
    }
    
    private func expandDetent() {
        detents.insert(.large)
        currentDetent = .large
    }
    
    private func shrinkDetent() {
        detents.insert(.small)
        currentDetent = .small
    }
    
    private func saveCurrentLocation() {
        
        let currentLocation : LocationItem = LocationItem(context: viewContext)
        currentLocation.locationId = UUID()
        currentLocation.timestamp = Date()
        currentLocation.longitude = vm.getUserLongitude()
        currentLocation.latitude = vm.getUserLatitude()
        currentLocation.name = StringConstant.untitled
        currentLocation.media = NSArray()
        
        do {
            try viewContext.save()
        } catch {
            print(StringConstant.failedSave)
            return
        }
        
        didAddNewLocation = true
        expandDetent()
        currentDetails = .archives
        
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
                emptyAction: shrinkDetent,
                newItemAdded: didAddNewLocation
            )
            
        case .none:
            
            EmptyView()
            
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
            saveColor: .accentColor,
            saveButtonAction: {
                saveCurrentLocation()
            },
            archivesColor: .gray,
            archivesButtonAction: {
                expandDetent()
                currentDetails = .archives
            }
        )
        
    }
    
}
