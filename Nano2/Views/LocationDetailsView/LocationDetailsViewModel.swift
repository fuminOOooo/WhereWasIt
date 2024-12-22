//
//  LocationDetailsViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import Foundation
import CoreData

public final class LocationDetailsViewModel : ObservableObject {
    
    public init() {}
    
    func getItemName(_ item: LocationItem) -> String {
        
        guard let name = item.name else { return String() }
        
        return name
        
    }
    
    func getItemTimestamp(_ item: LocationItem) -> String {
        
        guard let timestamp = item.timestamp else { return String() }
        
        return timestamp.formatted(date: .numeric, time: .omitted)
        
    }
    
}
