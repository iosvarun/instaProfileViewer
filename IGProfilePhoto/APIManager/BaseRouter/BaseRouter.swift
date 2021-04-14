//
//  BaseRouter.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

import Alamofire

enum BaseRouter: URLRequestConvertible {
    
    case instaRecorderRouterManager(InstaRecoderRouter)
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .instaRecorderRouterManager(let request):
            let mutableURLRequest = configureRequest(request)
            return mutableURLRequest
        }
    }

    /**
     Configuring Request for each of the cases.
     
     - parameter requestObj: An Object of the Router Protocol.
     - Contains Path of the Request.
     - Contains Method GET, POST, PUT
     - Contains Request Parameters
     - Contains Request Body
     
     - returns: <#return value description#>
     */
    func configureRequest(_ requestObj: BaseRouterProtocol, withURL baseURL: String? = APIConstants.baseURL) -> URLRequest {
        
//        let url =  URL(string: baseURL!)!
        let url =  URL(string: requestObj.urlString)!
        print("App request url \(url)")
        var mutableURLRequest = URLRequest(url: url)

        
        /// Set Request Path
//        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(requestObj.path))
        
        /**
         *  Set Request Method
         */
        mutableURLRequest.httpMethod = requestObj.method.rawValue
        
        //Set Request Headers
        //Common headers
//        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        mutableURLRequest.setValue(Config.environment.rawValue, forHTTPHeaderField: "X-Ay-Env")
        
        if let headers = requestObj.headers {
            for (key, value) in headers {
                mutableURLRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        /**
         *  Set Request Body if Method is POST or PUT
         */
        if requestObj.method == Alamofire.HTTPMethod.post || requestObj.method == Alamofire.HTTPMethod.get || requestObj.method == Alamofire.HTTPMethod.put {
            if let body = requestObj.body {
                do {
                    mutableURLRequest.httpBody =
                        try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                } catch {
                    
                }
            }
        }
        
        //// Set Request Parameters.
        if let parameters: Alamofire.Parameters = requestObj.parameters {
            do {
                return try Alamofire.URLEncoding.queryString.encode(mutableURLRequest as URLRequestConvertible, with: parameters)
            } catch {
                print(error)
            }
        }
        
        return mutableURLRequest
    }
    
}
