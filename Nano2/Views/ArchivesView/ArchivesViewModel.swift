//
//  ArchivesViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import Foundation

public final class ArchivesViewModel : ObservableObject {
    
    public init() {}
    
    public func getItemName(_ locationItem: LocationItem) -> String {
        return locationItem.name ?? String()
    }
    
}
