//
//  ArchivesView.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

struct ArchivesView: View {
    
    @FetchRequest(sortDescriptors: []) var locationitems: FetchedResults<LocationItem>
    
    public init(onDismiss: (@escaping () -> Void)) {
        self.onDismiss = onDismiss
    }
    
    @StateObject private var vm : ArchivesViewModel = .init()
    
    private let onDismiss : (() -> Void)
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section {
                    
                    ForEach(locationitems) { locationitem in
                        
                        let description = vm.getLocationItemDescription(locationitem)
                        
                        NavigationLink(description) {
                            Text(description)
                        }
                        
                    }
                
                } header: {
                    
                    Text(StringConstant.locationsSaved)
                    
                }
                
            }
            .listStyle(.insetGrouped)
        }
        .useCustomToolbar(
            StringConstant.listButtonText,
            onDismiss: {
                onDismiss()
            }
        )
    }
}
