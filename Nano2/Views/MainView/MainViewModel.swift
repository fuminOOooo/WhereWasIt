//
//  MainViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import Foundation

public final class MainViewModel: ObservableObject {
    
    init(
        _ userDefaultsService: UserDefaultsServiceable = UserDefaultsService.instance
    ) {
        
        self.sheetVisibility = true
        self.userDefaultsService = userDefaultsService
        guard let _ : Bool = userDefaultsService.get(CoreDataKeyConstant.notOpenedBefore) else
        {
            self.sheetVisibility = false
            return
        }
        
    }
    
    var userDefaultsService : (any UserDefaultsServiceable)
    
    @Published var sheetVisibility : Bool
    
}
