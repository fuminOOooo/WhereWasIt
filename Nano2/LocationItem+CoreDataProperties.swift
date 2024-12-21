//
//  LocationItem+CoreDataProperties.swift
//  Nano2
//
//  Created by Elvis Susanto on 20/12/24.
//
//

import Foundation
import CoreData


extension LocationItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationItem> {
        return NSFetchRequest<LocationItem>(entityName: "LocationItem")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var locationId: UUID?
    @NSManaged public var name: String?
    @NSManaged public var media: NSObject?

}

extension LocationItem : Identifiable {

}