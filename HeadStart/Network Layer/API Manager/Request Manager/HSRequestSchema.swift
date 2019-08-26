//
//  HSRequestSchema.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public protocol HSRequestSchema {
    var baseURL : URL { get }
    var path : String { get }
    var httpMethod : HSHttpMethod { get }
    var task : HSRequestTaskType { get }
    var headers : HSHTTPHeaders? { get }
}
