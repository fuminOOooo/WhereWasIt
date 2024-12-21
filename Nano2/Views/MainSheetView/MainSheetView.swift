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
    @State private var detents : Set<PresentationDetent> = [.small]
    @State private var currentDetent : PresentationDetent = .small
    @State private var saveLocation : Bool = false
    
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
              
            if expanded {
                
                ArchivesView()
                
            } else {
                
                VStack {
                    
                    Text(String(vm.savedLocationsCount) + StringConstant.space + StringConstant.locationsSaved)
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        
                        NavigationLink(
                            destination: SettingsView(
                                onDismiss: shrinkDetent
                            )
                        ) {
                            VStack {
                                
                                Image(systemName: ImageNameConstant.settingsButtonImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                
                                Text(StringConstant.settingsButtonText)
                                    .font(CustomFont.lightText14)
                                    .foregroundStyle(Color.primary)
                                
                            }
                        }
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                expandDetent()
                            }
                        )
                        
                        SystemImageButton(
                            StringConstant.pinButtonText,
                            imageName: ImageNameConstant.pinButtonImage
                        ) {
                            saveLocation.toggle()
                        }
                        
                        SystemImageButton(
                            StringConstant.listButtonText,
                            imageName: ImageNameConstant.listButtonImage
                        ) {
                            expandDetent()
                        }
                        
                    }
                    .padding([.horizontal, .bottom])
                    
                }
                
            }
            
        }
        .animation(.easeInOut, value: expanded)
        .padding(.top)
        .presentationDetents(detents, selection: $currentDetent)
        .presentationBackgroundInteraction(.enabled(upThrough: .small))
        .presentationDragIndicator(Visibility.hidden)
        .presentationCornerRadius(NumberConstant.defaultCornerRadiusSize)
        .interactiveDismissDisabled()
        .onChange(of: currentDetent, {
            
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
