//
//  HSNetworkLogger.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public  class HSNetworkLogger
{
    public static func log(request: URLRequest)
    {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        
        var headers:String = ""
        
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
            headers += #"""
            --header "\#(key): \#(value)" \
            """#
        }
        
        var bodyString:String = ""
        
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
            bodyString += #" "\#(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")" "#
        }
        
        print(logOutput)
        
        let curl = #"""
        curl --location --request \#(method) "\#(urlAsString)" \ \#(headers)
        --data \#(bodyString)
        """#
        print(curl)
    }
    
    public static func log(response: URLResponse?)
    {
        guard let response = response else { return }
        
        print(response)
    }
}
