//
//  HSParameterEncoding.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case jsonStringEncoding // sign in
    case uploadingMultiPart
    case multipleUploadingMultiPart
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws
    {
        do {
            switch self
            {
            case .urlEncoding:
                
                guard let urlParameters = urlParameters else { return }
                
                try HSURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                
                guard let bodyParameters = bodyParameters else { return }
                
                try HSJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                
                try HSURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
                try HSJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .jsonStringEncoding:
                
                guard let bodyParameters = bodyParameters else { return }
                
                try HSJSONStringParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .uploadingMultiPart:
                
                guard let parameters = bodyParameters else { return }
                
                try HSUploadMultiPartEncoder().encode(urlRequest: &urlRequest, with: parameters)
                
            case .multipleUploadingMultiPart:
                
                guard let parameters = bodyParameters else { return }
                
                try HSMultipleUploadMultiPartEncoder().encode(urlRequest: &urlRequest, with: parameters)
            }
        }
        catch
        {
            throw error
        }
    }
}


public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
