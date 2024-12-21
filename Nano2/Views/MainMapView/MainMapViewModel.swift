//
//  MainMapViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import Foundation
import CoreLocation
import CoreData

public final class MainMapViewModel : ObservableObject {
    
    init(
        _ coreLocationService: CoreLocationServiceable = CoreLocationService.instance
    ) {
        self.coreLocationService = coreLocationService
    }
    
    var coreLocationService : (any CoreLocationServiceable)
    
    func getUserCoordinates() -> CLLocationCoordinate2D {
        
        return CLLocationCoordinate2D(latitude: getUserLatitude(), longitude: getUserLongitude())
        
    }
    
    func getUserLongitude() -> CGFloat {
        
        let x = coreLocationService.getUserLocation().coordinate.longitude
        return x
        
    }
    
    func getUserLatitude() -> CGFloat {
        
        let y = coreLocationService.getUserLocation().coordinate.latitude
        return y
        
    }
    
}
