//
//  InstaRecoderRouter.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 13/04/21.
//

import Foundation

import Alamofire

enum InstaRecoderRouter: BaseRouterProtocol {

    case searchUser(String)
    case userChannel(String)

    
    var path: String {
        switch self {
        case .searchUser(_), .userChannel(_):
        return Config.baseURL
        
        }
    }
    var endPoint: String {
        switch self {
        case .userChannel(let userName):
            return userName + APIConstants.userChannel
        case .searchUser(let userName):
            return APIConstants.topsearchAPI + userName
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .userChannel(_):
            return .get
        case .searchUser(_):
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var body: AnyObject? {
        switch self {
        case .userChannel(_):
            return nil
//            return requestBody as AnyObject?
        default:
            return nil
        }
    }
    
    var headers: RequestHeaders? {

        
        var headers = RequestHeaders()
            headers = ["Content-Type": "application/json",
                       "accept": "application/json"]
        switch self {
        case .userChannel(_):
            return nil
        case .searchUser(_):
            return nil
        }
    }
    
    var urlString : String {
        switch self {
        case .userChannel(_):
            return path + endPoint
        case .searchUser(_):
            return path + endPoint + "&count=50"
        }
    }

    
}
