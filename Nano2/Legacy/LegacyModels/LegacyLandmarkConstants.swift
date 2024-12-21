////
////  Landmark.swift
////  Nano2
////
////  Created by Elvis Susanto on 25/05/23.
////
//
//import Foundation
//import CoreLocation
//import MapKit
//
//struct Landmark {
//    
//    let placemark: MKPlacemark
//    
//    var id: UUID {
//        return UUID()
//    }
//    
//    var name: String {
//        self.placemark.name ?? ""
//    }
//    
//    var title: String {
//        self.placemark.title ?? ""
//    }
//    
//    var coordinate: CLLocationCoordinate2D {
//        self.placemark.coordinate
//    }
//    
//}
//
//final class LandmarkAnnotation: NSObject, MKAnnotation {
//    let title: String?
//    let coordinate: CLLocationCoordinate2D
//    init (landmark: Landmark) {
//        self.title = landmark.name
//        self.coordinate = landmark.coordinate
//    }
//}
