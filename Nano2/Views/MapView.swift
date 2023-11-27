//
//  MapView.swift
//  Nano2
//
//  Created by Elvis Susanto on 25/05/23.
//

import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        control.landmarkClicked.toggle()
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion (center: annotation.coordinate, latitudinalMeters: 350, longitudinalMeters: 350)
                    mapView.setRegion (region, animated: true)
                    
                }
            }
        }
        
    }
    
}

struct MapView: UIViewRepresentable {
    
    let landmark: [Landmark]
    
    @Binding var landmarkSearched: Bool
    
    @Binding var landmarkClicked: Bool
    
    @Binding var currentRegion: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        if let userTrackingButton = uiView.subviews.first(where: { $0 is MKUserTrackingButton }) as? MKUserTrackingButton {
            userTrackingButton.frame = CGRect(origin: CGPoint(x: 345, y: 620), size: CGSize(width: 35, height: 35))
        } else {
            let userTrackingButton = MKUserTrackingButton(mapView: uiView)
            userTrackingButton.frame = CGRect(origin: CGPoint(x: 345, y: 620), size: CGSize(width: 35, height: 35))
            userTrackingButton.backgroundColor = UIColor.black
            userTrackingButton.layer.cornerRadius = 10
            userTrackingButton.layer.opacity = 1
            uiView.addSubview(userTrackingButton)
        }
        
        updateAnnotations(from: uiView)
        
        if landmarkSearched == true && !landmark.isEmpty {
            uiView.setCenter(landmark[0].coordinate, animated: true)
            landmarkSearched = false
        }
        
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = self.landmark.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotation)
        
    }
    
}
