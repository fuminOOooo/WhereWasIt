//
//  MainViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import Foundation

public final class FirstTimeOpenViewModel: ObservableObject {
    
    init(
        _ userDefaultsService: UserDefaultsServiceable = UserDefaultsService.instance
    ) {
        self.userDefaultsService = userDefaultsService
    }
    
    var userDefaultsService : (any UserDefaultsServiceable)
    
    public func firstTimeCheck() -> Bool {
        
        guard let notOpenedBefore : Bool = userDefaultsService.get(StringConstant.notOpenedBefore) else { return true }
        
        return notOpenedBefore
        
    }
    
    public func setFirstTime() {
        
        userDefaultsService.set(key: StringConstant.notOpenedBefore, false)
        
    }
    
}
