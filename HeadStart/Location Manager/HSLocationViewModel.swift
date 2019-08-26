//
//  HSLocationViewModel.swift
//  HeadStart
//
//  Created by Ashfauck on 8/26/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public class HSLocationViewModel: NSObject
{
    
    
    public static let shared = HSLocationViewModel(locationProvider: HSUserLocationService())
    
    public var locationProvider:HSUserLocationProvider
    
    public var userLocationCompletion:UserLocationCompletionBlock?
    
    public var userLocation:Coordinate? = nil
    
    init(locationProvider:HSUserLocationProvider)
    {
        self.locationProvider = locationProvider
        
        super.init()
        
        self.requestUserLocation()
    }
    
    public func requestUserLocation()
    {
        locationProvider.findUserLocation { [weak self] location, error in
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
        self.locationProvider.stopUserLocationUpdate()
    }

}
