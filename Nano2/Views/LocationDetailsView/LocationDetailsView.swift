//
//  LocationDetailsView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI

struct LocationDetailsView: View {
    
    public init(locationItem: LocationItem) {
        self.locationItem = locationItem
    }
    
    private var locationItem : LocationItem
    @StateObject private var vm : LocationDetailsViewModel = .init()
    
    var body: some View {
        
        ScrollView {
            
            Text(vm.getItemName(locationItem))
                .font(.largeTitle)
                .bold()
            
            Text(vm.getItemTimestamp(locationItem))
                .padding(.bottom)
            
            PicturesView(
                vm.checkForItemMedia(locationItem),
                item: locationItem
            )
            
        }
        .padding(.horizontal)
        
    }
    
}
