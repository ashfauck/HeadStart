//
//  HSLocationViewModel.swift
//  HeadStart
//
//  Created by Ashfauck on 8/26/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit
import CoreLocation

public class HSLocationViewModel: NSObject
{
    public static let shared = HSLocationViewModel()
    
    public let locationService = HSUserLocationService()
    
    public var userLocationCompletion:UserLocationCompletionBlock?
    
    public var userLocation:Coordinate? = nil
    
    public var locationManager = CLLocationManager()

    override init()
    {
        super.init()
    }
    
    public func requestUserLocation()
    {
        
        locationService.findUserLocation { [weak self] location, error in
            if error == nil
            {
                self?.userLocation = location?.coordinate
                
                self?.userLocationCompletion?(location,error)
            }
            else
            {
                self?.userLocation = nil
                
                print("User can not be located 😔")
                self?.userLocationCompletion?(nil,error)
            }
        }
    }
    
    public func stopUserLocationUpdate()
    {
        self.userLocation = nil
        self.userLocationCompletion = nil
        self.locationService.stopUserLocationUpdate()
    }

}
