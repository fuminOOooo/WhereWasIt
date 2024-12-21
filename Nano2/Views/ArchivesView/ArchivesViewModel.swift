//
//  ArchivesViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import Foundation

public final class ArchivesViewModel : ObservableObject {
    
    public init() {}
    
    func getLocationItemDescription(_ item : LocationItem) -> String {
        
        let name = item.name ?? String()
        let timestamp = item.timestamp?.formatted(date: .numeric, time: .omitted) ?? String()
        return name + StringConstant.space + StringConstant.dash + StringConstant.space + timestamp
        
    }
    
}
