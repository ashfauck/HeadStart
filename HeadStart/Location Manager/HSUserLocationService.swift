//
//  HSUserLocationService.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Vagus. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class HSUserLocationService: NSObject, HSUserLocationProvider {
    
    fileprivate var locationCompletionBlock: UserLocationCompletionBlock?
    fileprivate var isLocatoinDisableScreenOpened:Bool = false
    private lazy var locationManager: CLLocationManager =
    {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.delegate = self
        
        locationManager.activityType = .automotiveNavigation
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager.startMonitoringSignificantLocationChanges()

        return locationManager
    }()
    
    func findUserLocation(then: @escaping UserLocationCompletionBlock)
    {
        self.locationCompletionBlock = then
        
        if locationManager.isNotDetermined
        {
            isLocatoinDisableScreenOpened = false
            locationManager.requestAlwaysAuthorization()
        }
        else if locationManager.isUserAuthorized
        {
            isLocatoinDisableScreenOpened = false
            locationManager.startUpdatingLocation()
        }
        else
        {
            if !isLocatoinDisableScreenOpened
            {
                isLocatoinDisableScreenOpened = true
                
                let locationDisableVC = HSLocationWarningViewController()
                
                if let rootVC = UIApplication.shared.keyWindow?.rootViewController
                {
                    rootVC.present(locationDisableVC, animated: true, completion: nil)
                }
            }
            
            print("Location service is disabled or permission denied")
        }
    }
    
    func stopUserLocationUpdate()
    {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }
}


extension HSUserLocationService: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse || status == .authorizedAlways
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last
        {
            locationCompletionBlock?(location, nil)
        }
        else
        {
            locationCompletionBlock?(nil, .canNotBeLocated)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        locationCompletionBlock?(nil, .canNotBeLocated)
    }
}
