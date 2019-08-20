//
//  AFLocationManager.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Vagus. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationProvider
{
    var isUserAuthorized: Bool { get }
}

extension CLLocationManager: LocationProvider
{
    var isUserAuthorized: Bool
    {
        return [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
    
    var isNotDetermined:Bool
    {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
    
}
