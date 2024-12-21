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
    
    @Published var savedLocationsCount : Int = .init()
    
    @Published var savedLocationName : String = .init()
    
    func saveCurrentLocation(context : NSManagedObjectContext) {
        
        let currentLocation : LocationItem = LocationItem(context: context)
        currentLocation.locationId = UUID()
        currentLocation.timestamp = Date()
        currentLocation.longitude = coreLocationService.getUserLocation().coordinate.longitude
        currentLocation.latitude = coreLocationService.getUserLocation().coordinate.latitude
        currentLocation.name = savedLocationName
        currentLocation.media = NSArray()
        
        do {
            try context.save()
        } catch {
            print(StringConstant.failedSave)
        }
        
    }
    
}
