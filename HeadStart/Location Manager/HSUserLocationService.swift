//
//  HSUserLocationService.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

public class HSUserLocationService: NSObject, HSUserLocationProvider {
    public var locationManager: CLLocationManager = CLLocationManager()
    
    
    fileprivate var locationCompletionBlock: UserLocationCompletionBlock?
    fileprivate var isLocatoinDisableScreenOpened:Bool = false
    public var locationManagers: CLLocationManager = CLLocationManager()
    
    public override init()
    {
        super.init()
        
        // Configure Location Manager
        self.locationManagers.delegate = self
        
        self.locationManagers.activityType = .automotiveNavigation
        
        self.locationManagers.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        self.locationManagers.startMonitoringSignificantLocationChanges()
        
        self.locationManager = self.locationManagers
    }
    
    public func findUserLocation(then: @escaping UserLocationCompletionBlock)
    {
        self.locationCompletionBlock = then
        
        if locationManagers.isNotDetermined
        {
            isLocatoinDisableScreenOpened = false
            locationManagers.requestAlwaysAuthorization()
        }
        else if locationManagers.isUserAuthorized
        {
            isLocatoinDisableScreenOpened = false
            locationManagers.startUpdatingLocation()
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
    
    public func stopUserLocationUpdate()
    {
        self.locationManagers.stopUpdatingLocation()
        self.locationManagers.stopMonitoringSignificantLocationChanges()
    }
}


extension HSUserLocationService: CLLocationManagerDelegate
{
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse || status == .authorizedAlways
        {
            locationManagers.startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
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
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        locationCompletionBlock?(nil, .canNotBeLocated)
    }
}
