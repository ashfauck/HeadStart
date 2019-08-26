//
//  HSUserLocationProvider.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import CoreLocation

public enum UserLocationError: Error
{
    case canNotBeLocated
}

public typealias UserLocationCompletionBlock = (HSUserLocation?, UserLocationError?) -> Void

public protocol HSUserLocationProvider
{
    func findUserLocation(then: @escaping UserLocationCompletionBlock)
    func stopUserLocationUpdate()
    var locationManager:CLLocationManager { get }
}
