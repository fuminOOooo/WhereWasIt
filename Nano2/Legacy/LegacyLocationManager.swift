////
////  MapViewModel.swift
////  TesMapKit
////
////  Created by Elvis Susanto on 16/05/23.
////
//
//import Foundation
//import MapKit
//import CoreLocation
//
//class LocationManager: NSObject, ObservableObject {
//    
//    private let locationManager = CLLocationManager()
//    
//    @Published var location: CLLocation? = nil
//    
//    override init() {
//        
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//        
//    }
//    
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {
//            return
//        }
//        self.location = location
//    }
//    
//}
