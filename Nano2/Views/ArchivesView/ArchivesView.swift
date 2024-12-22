//
//  ArchivesView.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

struct ArchivesView: View {
    
    @FetchRequest(sortDescriptors: []) var locationitems: FetchedResults<LocationItem>
    
    public init(onDismiss: (@escaping () -> Void), emptyAction: (@escaping () -> Void)) {
        self.onDismiss = onDismiss
        self.emptyAction = emptyAction
    }
    
    @StateObject private var vm : ArchivesViewModel = .init()
    
    private let onDismiss : (() -> Void)
    private let emptyAction : (() -> Void)
    
    var body: some View {
        
        NavigationStack {
            
            if locationitems.isEmpty {
                
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
                        
                        ForEach(locationitems) { locationitem in
                            
                            NavigationLink(vm.getItemName(locationitem)) {
                                
                                LocationDetailsView(locationItem: locationitem)
                                
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
        .navigationBarBackButtonHidden()
    }
}
