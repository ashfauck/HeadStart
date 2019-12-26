//
//  HSJsonParameterEncoding.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public struct HSJSONParameterEncoder: ParameterEncoder
{
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil
            {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

public struct HSJSONStringParameterEncoder: ParameterEncoder
{
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
    {
        let urlParams = parameters.compactMap({ (key, value) -> String in
            return "\(key)=\(value as? String ?? "")"
        }).joined(separator: "&")
        
        urlRequest.httpBody = urlParams.data(using: String.Encoding.utf8)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("text", forHTTPHeaderField: "Content-Type")
        }
    }
}

public struct HSUploadMultiPartEncoder: ParameterEncoder
{
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        guard let data = parameters["data"] as? Data else { return }
        
        let bodyData = createBody(parameters: [:], boundary: boundary, data: data, mimeType: parameters["mimetype"] as? String ?? "", filename: parameters["filename"] as? String ?? "")
        
        urlRequest.httpBody = bodyData
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
    }
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
}


public struct HSMultipleUploadMultiPartEncoder: ParameterEncoder
{
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        if let fileParts = parameters["fileParts"] as? [FilePartData], fileParts.count > 0
        {
            let bodyData = self.createBody(parameters: [:], boundary: boundary, fileParts: fileParts)
            
            urlRequest.httpBody = bodyData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil
            {
                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            }
        }
    }
    
    func createBody(parameters: [String: String],
                    boundary: String, fileParts:[FilePartData]) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters
        {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        fileParts.forEach { (filePart) in
            
            if let fileName = filePart.filename, let data = filePart.data, let mimeType = filePart.mimeType
            {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"attachment\"; filename=\"\(fileName)\"\r\n")
                body.appendString("Content-Type: \(mimeType)\r\n\r\n")
                body.append(data)
                body.appendString("\r\n")
                body.appendString("--".appending(boundary.appending("--")))
            }
            
            
        }
        
        
        return body as Data
    }
}


public struct FilePartData
{
    public var filename:String?
    public var mimeType:String?
    public var data:Data?
    
    init(fileName:String?, mimeType:String?, data:Data?)
    {
        self.filename = fileName
        self.mimeType = mimeType
        self.data = data
    }
}
