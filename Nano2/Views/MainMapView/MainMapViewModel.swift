//
//  MainMapViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import Foundation

public final class MainMapViewModel : ObservableObject {
    
    init(
        _ coreLocationService: CoreLocationServiceable = CoreLocationService.instance
    ) {
        self.coreLocationService = coreLocationService
    }
    
    var coreLocationService : (any CoreLocationServiceable)
    
    func getUserLongitude() -> CGFloat {
        
        let x = coreLocationService.userLocation.coordinate.longitude
        return x
        
    }
    
    func getUserLatitude() -> CGFloat {
        
        let y = coreLocationService.userLocation.coordinate.latitude
        return y
        
    }
    
}
