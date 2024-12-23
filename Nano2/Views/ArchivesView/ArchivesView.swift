//
//  ArchivesView.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

struct ArchivesView: View {
    
    @FetchRequest(sortDescriptors: []) var locationItems: FetchedResults<LocationItem>
    
    public init(
        onDismiss: (@escaping () -> Void),
        emptyAction: (@escaping () -> Void),
        newItemAdded: Bool = false
    ) {
        self.onDismiss = onDismiss
        self.emptyAction = emptyAction
        self.newItemAdded = newItemAdded
    }
    
    @State private var newItemAdded : Bool
    @State private var path : NavigationPath = .init()
    @StateObject private var vm : ArchivesViewModel = .init()
    
    private let onDismiss : (() -> Void)
    private let emptyAction : (() -> Void)
    @State private var router: ItemRouter = .init()
    
    var body: some View {
        
        NavigationStack (path: $router.navigationPath) {
            
            if locationItems.isEmpty {
                
                VStack {
                    
                    Text(StringConstant.startSaving)
                        .bold()
                    
                    Button {
                        emptyAction()
                    } label: {
                        Text(StringConstant.mainMenu)
                    }
                    .withFillButtonStyle()
                    .padding()
                    
                }
                .padding(.horizontal)
                
            } else {
                
                List {
                    
                    Section {
                        
                        ForEach(locationItems) { locationItem in
                            
                            NavigationLink(
                                
                                vm.getItemName(locationItem)
                                
                            ) {
                                
                                getItemDetailView(locationItem)
                                
                            }
                            .onAppear {
                                
                                if !checkIfLast(id: locationItem.id) { return }
                                
                                if !newItemAdded { return }
                                
                                router.navigateTo(
                                    route: .itemDetail(
                                        item: locationItem
                                    )
                                )
                                
                                newItemAdded = false
                                
                            }
                            
                        }
                        
                    } header: {
                        
                        Text(StringConstant.locationsSaved)
                        
                    }
                    
                }
                .listStyle(.insetGrouped)
                
            }
            
        }
        .useCustomToolbar(
            StringConstant.listButtonText,
            onDismiss: {
                onDismiss()
            }
        )
        
    }
}

private extension ArchivesView {
    
    private func getItemDetailView(_ item: LocationItem) -> some View {
        return LocationDetailsView(locationItem: item)
    }
    
    private func checkIfLast(id: ObjectIdentifier) -> Bool {
        
        return id == locationItems.last?.id
        
    }
    
    private enum ItemRoute : Hashable {
        
        case itemDetail(item: LocationItem)
        
    }
    
    private class ItemRouter : ObservableObject {
        
        public var navigationPath = NavigationPath()

        func navigateTo(route: ItemRoute) {
            
            navigationPath.append(route)
            
        }
    }
    
}
