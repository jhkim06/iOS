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
    var regionUpdates: [RegionUpdate] = []
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        loadRegionUpdates()
        
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
                         didFailWithError error: Error) {
        printLog("locationManager didFailWithError: \(error)")
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations:[CLLocation]){
        guard let location = locations.last else {return}
        printLog("location: \(location)")
        
        let region = CLCircularRegion(center: location.coordinate,
                                      radius: 10, // 10 m
        identifier: "home")
        
        manager.startMonitoring(for: region)
    }
    func locationManager(_ manager: CLLocationManager,
                         didEnterRegion region: CLRegion){
        printLog("didEnterRegion: \(String(describing: region))")
        addRegionUpdate(type: .enter)
    }
    func locationManager(_ manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        printLog("didExitRegion: \(String(describing: region))")
        addRegionUpdate(type: .exit)
    }
    
    // update regionUpdates
    func addRegionUpdate(type: UpdateType) {
        
        let lastUpdateType = regionUpdates.last?.updateType
        if type != lastUpdateType {
            // where come the date?
            let regionUpdate = RegionUpdate(date: Date(), updateType: type)
            regionUpdates.append(regionUpdate)
            
            writeRegionUpdates()
        }
    }
    
    func writeRegionUpdates() {
        do {
            let data = try JSONEncoder().encode(regionUpdates)
            try data.write(to: FileManager.regionUpdatesDataPath(), options: .atomic)
        } catch {
            printLog("error: \(error)")
        }
    }
    
    func loadRegionUpdates() {
        do {
            let data = try Data(contentsOf: FileManager.regionUpdatesDataPath())
            regionUpdates = try JSONDecoder().decode([RegionUpdate].self,
                                                     from: data)
        } catch {
            printLog("error: \(error)")
        }
    }
    
}
