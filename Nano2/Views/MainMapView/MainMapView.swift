//
//  MainMapView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    
    public init (
        vm: MainMapViewModel = MainMapViewModel()
    ) {
        self.vm = vm
    }
    
    @ObservedObject var vm : MainMapViewModel
    
    var body: some View {
        
        Map {
            
            UserAnnotation(
                anchor: UnitPoint(
                    x: vm.getUserLongitude(),
                    y: vm.getUserLatitude()
                )
            )
            
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
        .mapControlVisibility(.visible)
        .controlSize(.extraLarge)
        .mapStyle(.hybrid)
        
    }
    
}

#Preview {
    
    MainMapView()
    
}
