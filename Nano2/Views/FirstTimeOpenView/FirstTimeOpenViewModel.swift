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
        guard let notOpenedBefore : Bool = userDefaultsService.get(CoreDataKeyConstant.notOpenedBefore) else {
            notOpenedBefore = true
            return
        }
        self.notOpenedBefore = notOpenedBefore
    }
    
    @Published var notOpenedBefore : Bool
    
    var userDefaultsService : (any UserDefaultsServiceable)
    
    public func setFirstTime() {
        
        userDefaultsService.set(key: CoreDataKeyConstant.notOpenedBefore, false)
        
    }
    
}
