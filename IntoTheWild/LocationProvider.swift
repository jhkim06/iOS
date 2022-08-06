//
//  LocationProvider.swift
//  IntoTheWild
//
//  Created by Junho Kim on 2022/08/06.
//

import UIKit
import CoreLocation
import LogStore

class LocationProvider: NSObject,
                        CLLocationManagerDelegate {
    let locationManager: CLLocationManager
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            printLog("sucess")
        case .notDetermined:
            printLog("notDetermined")
        default:
            break
        }
    }
    func setHome() {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations:[CLLocation]){
        guard let location = locations.last else {return}
        printLog("location: \(location)")
    }
}
