//
//  MapView.swift
//  MappeAppleTv
//
//  Created by Michele Manniello on 01/11/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var mapData : MapViewModel
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapview
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    class Coordinator: NSObject,MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            Custom Pins..
            
//            Excluding User Blue Circle..
            if annotation.isKind(of: MKUserLocation.self){return nil}
            else{
                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesWhenAdded = true
                pinAnnotation.canShowCallout = true
                return pinAnnotation
            }
        }
    }
}

