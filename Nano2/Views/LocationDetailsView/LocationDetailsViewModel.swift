//
//  LocationDetailsViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import Foundation

public final class LocationDetailsViewModel : ObservableObject {
    
    func checkForItemMedia(_ item: LocationItem) -> Bool {
        
        guard let media = item.media as? NSArray else { return false }
        
        return media.count == .zero ? false : true
        
    }
    
    func getItemName(_ item: LocationItem) -> String {
        
        guard let name = item.name else { return String() }
        
        return name
        
    }
    
    func getItemTimestamp(_ item: LocationItem) -> String {
        
        guard let timestamp = item.timestamp else { return String() }
        
        return timestamp.formatted(date: .numeric, time: .standard)
        
    }
    
}
