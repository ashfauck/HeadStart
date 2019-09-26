//
//  HSUserLocation.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import CoreLocation

public typealias Coordinate = CLLocationCoordinate2D

public protocol HSUserLocation
{
    var coordinate: Coordinate { get }
    var speed:CLLocationSpeed { get }
}

extension CLLocation: HSUserLocation { }

//public typealias AuthorizationStatus = CLAuthorizationStatus
//
//public protocol HSLocationManager
//{
//    var status: AuthorizationStatus { get }
//}
//
//extension CLLocationManager: HSLocationManager { }
