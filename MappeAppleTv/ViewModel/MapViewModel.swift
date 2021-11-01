//
//  MapViewModel.swift
//  MappeAppleTv
//
//  Created by Michele Manniello on 01/11/21.
//

import SwiftUI
import MapKit
import CoreLocation
class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    @Published var mapview = MKMapView()
    let locationManager = CLLocationManager()
    
    //    Region
    @Published var region: MKCoordinateRegion!
    
    //    Alert
    @Published var permissionDenied = false
    
    //    Map Type...
    @Published var mapType: MKMapType = .standard
    
    //    Search text...
    @Published var serachTxt = ""
    
    //    Searched Places..
    @Published var places : [Place] = []
    
    //    Updating Map Type..
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapview.mapType = mapType
        }else{
            mapType = .standard
            mapview.mapType = mapType
        }
    }
    
        //    focus Location...
        func focusLocation(){
            guard let _ = region else { return }
            mapview.setRegion(region, animated: true)
            mapview.setVisibleMapRect(mapview.visibleMapRect, animated: true)
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            //        Checking Permission...
            switch manager.authorizationStatus{
            case .denied:
                //            alert
                permissionDenied.toggle()
            case .notDetermined:
                //            Requesting..
                manager.requestLocation()
            case .authorizedWhenInUse:
                manager.requestLocation()
            default:
                ()
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            //        Error..
            print(error.localizedDescription)
        }
        //  Getting user Region...
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.mapview.setRegion(self.region, animated: true)
            //        Smooth Animation...
            self.mapview.setVisibleMapRect(self.mapview.visibleMapRect, animated: true)
        }
        
    }

struct Place: Identifiable {
    var id = UUID().uuidString
    var placemark: CLPlacemark
}
