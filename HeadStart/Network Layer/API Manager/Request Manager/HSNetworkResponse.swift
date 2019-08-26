//
//  HSNetworkResponse.swift
//  HeadStart
//
//  Created by Ashfauck Thaminsali on 4/25/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit

public enum HSNetworkResponse:Error {
    case success
    case authenticationError
    case badRequest
    case notFound
    case outdated
    case requestFailed
    case noData
    case unableToDecode
    case networkFailed
    case commonError
    
    var detail:String {
        
        switch self {
        case .success:
            return "Success".localized()
        case .authenticationError:
            return "You need to be authenticated first.".localized()
        case .badRequest:
            return  "Bad request".localized()
        case .outdated:
            return "The url you requested is outdated."
        case .requestFailed:
            return "Network request failed.".localized()
        case .notFound:
            return "Not found".localized()
        case .noData:
            return "Response returned with no data to decode.".localized()
        case .unableToDecode:
            return "We could not decode the response.".localized()
        case .networkFailed:
            return "Unable to connect to the internet".localized()
        case .commonError:
            return self.localizedDescription
        }
        
    }
    
}

extension HTTPURLResponse
{
    public func verifyResponse() -> ResponseCheck<String>
    {
        switch self.statusCode
        {
        case 200...299:
            return .success
        case 400:
            return .failure(HSNetworkResponse.badRequest.detail)
        case 404:
            return .failure(HSNetworkResponse.notFound.detail)
        case 401...500:
            return .failure(HSNetworkResponse.authenticationError.detail)
        case 501...599:
            return .failure(HSNetworkResponse.badRequest.detail)
        case 600:
            return .failure(HSNetworkResponse.outdated.detail)
        default:
            return .failure(HSNetworkResponse.requestFailed.detail)
        }
    }
}

public enum ResponseCheck<String>
{
    case success
    case failure(String)
}

