//
//  HSRequestTaskType.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit


public typealias HSHTTPHeaders = [String:String]

public enum HSRequestTaskType {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HSHTTPHeaders?)
}

