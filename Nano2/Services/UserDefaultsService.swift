//
//  UserDefaultsService.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import Foundation

protocol UserDefaultsServiceable {
    func get<T>(_ key: String) -> T?
    func set<T>(key: String, _ value: T)
}

public final class UserDefaultsService: UserDefaultsServiceable {
    
    public static let instance = UserDefaultsService()
    
    private let userDefaults = UserDefaults.standard
    
    func get<T>(_ key: String) -> T? {
        
        guard let result = userDefaults.value(forKey: key) as? T else {
            
            print("Failed getting value for \(key)")
            return nil
            
        }
        
        return result
        
    }
    
    func set<T>(key: String, _ value: T) {
        
        userDefaults.set(value, forKey: key)
        
    }
    
}
