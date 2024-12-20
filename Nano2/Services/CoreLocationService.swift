//
//  CoreLocationService.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/20/24.
//

import CoreLocation
import Foundation

protocol CoreLocationServiceable {
    var userLocation : CLLocation { get }
}

public final class CoreLocationService : NSObject, CoreLocationServiceable {
    
    public static let instance = CoreLocationService()
    
    init (
        locationManager: CLLocationManager = CLLocationManager(),
        delegate: CLLocationManagerDelegate? = nil
    ) {
        
        self.locationManager = locationManager
        
        super.init()
        
        if let delegate = delegate {
            locationManager.delegate = delegate
        } else {
            locationManager.delegate = self
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    public var userLocation : CLLocation = .init()
    
    private var locationManager: CLLocationManager
    
}

extension CoreLocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        self.userLocation = location
        
    }
    
}
