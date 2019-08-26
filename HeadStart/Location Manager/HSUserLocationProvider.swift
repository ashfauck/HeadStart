//
//  HSUserLocationProvider.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation

enum UserLocationError: Error
{
    case canNotBeLocated
}

typealias UserLocationCompletionBlock = (HSUserLocation?, UserLocationError?) -> Void

protocol HSUserLocationProvider
{
    func findUserLocation(then: @escaping UserLocationCompletionBlock)
    func stopUserLocationUpdate()
}
