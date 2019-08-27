//
//  HSLocationManager.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import CoreLocation

public protocol LocationProvider
{
    var isUserAuthorized: Bool { get }
    var isNotDetermined:Bool  { get }
    var status:CLAuthorizationStatus { get }
}

extension CLLocationManager: LocationProvider
{
    public var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    public var isUserAuthorized: Bool
    {
        return [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
    
    public var isNotDetermined:Bool
    {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
}
