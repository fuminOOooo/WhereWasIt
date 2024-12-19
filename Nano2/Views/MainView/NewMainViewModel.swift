//
//  NewMainViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import Foundation

public final class NewMainViewModel: ObservableObject {
    
    init(
        _ userDefaultsService: UserDefaultsServiceable = UserDefaultsService.instance
    ) {
        self.userDefaultsService = userDefaultsService
    }
    
    let userDefaultsService : UserDefaultsServiceable
    
    public func firstTimeCheck() -> Bool {
        
        guard let notOpenedBefore : Bool = userDefaultsService.get(StringConstant.notOpenedBefore) else { return true }
        
        return notOpenedBefore
        
    }
    
    public func setFirstTime() {
        
        userDefaultsService.set(key: StringConstant.notOpenedBefore, false)
        
    }
    
}
