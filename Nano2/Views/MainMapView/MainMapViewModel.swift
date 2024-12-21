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
    
    @Published var locationItems : [LocationItem] = []
    
    func getUserCoordinates() -> CLLocationCoordinate2D {
        
        return CLLocationCoordinate2D(latitude: getUserLatitude(), longitude: getUserLongitude())
        
    }
    
    func getAllMapPins(context: NSManagedObjectContext) {
        
        let request = NSFetchRequest<LocationItem>(entityName: CoreDataKeyConstant.locationItem)
        do {
            let fetchedItems = try context.fetch(request)
            locationItems = fetchedItems
        } catch {
            fatalError("Failed to fetch items: \(error)")
        }
        
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
