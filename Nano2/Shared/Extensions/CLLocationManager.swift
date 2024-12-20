//
//  CLLocationManager.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import CoreLocation

extension CLLocationManager {
    
    convenience override init() {
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
}
