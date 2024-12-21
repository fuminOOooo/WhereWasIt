//
//  MainMapView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    public init (
        vm: MainMapViewModel = MainMapViewModel()
    ) {
        self.vm = vm
        self.initialCameraPosition = {
            let cameraPosition  = MapCameraPosition.item(MKMapItem.forCurrentLocation())
            return MapCameraPosition.userLocation(followsHeading: true, fallback: cameraPosition)
        }()
        self.vm.getAllMapPins(context: viewContext)
    }
    
    @ObservedObject var vm : MainMapViewModel
    
    @State private var initialCameraPosition : MapCameraPosition
    
    var body: some View {
        
        Map(position: $initialCameraPosition, interactionModes: .all) {
            
            UserAnnotation(
                anchor: UnitPoint(
                    x: vm.getUserLongitude(),
                    y: vm.getUserLatitude()
                )
            )
            
        }
        .mapControlVisibility(.visible)
        .controlSize(.extraLarge)
        .mapStyle(.standard)
        .mapControls {
            
            MapCompass()
            MapUserLocationButton()
            MapPitchToggle()

        }
        
    }
    
}

#Preview {
    
    MainMapView()
    
}
