//
//  HSUserLocation.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D

protocol HSUserLocation
{
    var coordinate: Coordinate { get }
}

extension CLLocation: HSUserLocation { }

