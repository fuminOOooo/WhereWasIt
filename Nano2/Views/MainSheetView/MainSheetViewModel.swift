//
//  MainSheetViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import Foundation
import CoreLocation
import CoreData

public final class MainSheetViewModel: ObservableObject {
    
    init(
        _ coreLocationService: CoreLocationServiceable = CoreLocationService.instance
    ) {
        self.coreLocationService = coreLocationService
    }
    
    var coreLocationService : (any CoreLocationServiceable)
    
    func getUserLongitude() -> Double {
        
        return coreLocationService.getUserLocation().coordinate.longitude
        
    }
    
    func getUserLatitude() -> Double {
        
        return coreLocationService.getUserLocation().coordinate.latitude
        
    }
    
}
