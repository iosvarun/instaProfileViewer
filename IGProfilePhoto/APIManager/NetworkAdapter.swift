//
//  NetworkAdapter.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import Alamofire
import Reachability

let NetworkAdapterErrorDomain = "com.onechat.networkadaptor"

public class HttpResponseError: NSError {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Custom Initializer.
    ///
    /// - Parameters:
    ///   - statusCode: Http Status Code.
    ///   - serverErrorCode: Error Code sent from the server in response body.
    ///   - serverErrorDescription: Error Description sent from the server in response body.
    
    public init(domain:String?, statusCode: Int, serverErrorDescription: String?) {
        super.init(domain: domain != nil ? domain! : "", code: statusCode, userInfo: [NSLocalizedDescriptionKey : serverErrorDescription != nil ? serverErrorDescription!: ""])
    }
}

/// Network Adapter for routing all the Requests. It is a wrapper around Alamofire Request method to provide custom hooks for the requests and response.

public class NetworkAdapter {
    
    private static var reachability:Reachability! {
        do {
            return try Reachability()
        }
        catch { return nil }
    }
    
    public class func request(_ urlRequest: URLRequestConvertible,
                              completionHandler: @escaping (Any) -> Void,
                              errorHandler: @escaping (NSError) -> Void,
                              networkErrorHandler: () -> Void) {
        
        if reachability.isReachable {
            
            AF.request(urlRequest).validate().debugLog().cURLDescription(calling: { (description) in
                print(description)
            }).responseJSON(completionHandler: { (response) in
                print("NetworkAdapter request response result \(response.result)")
                print("NetworkAdapter request response \(String(describing: response.value))")

            })
            .responseData { (response) in
                
                guard response.value != nil else  {
                    if let error = response.error {
                        errorHandler(self.handleError(error) as NSError)
                    }
                    return
                }
                
                completionHandler(response.value!)
            }
            
        } else {
            networkErrorHandler()
        }
 
    }
    
    /// Method to create and return HttpResponseError if error is encountered
    ///
    /// - Parameter response: Data Response received from the Server.
    /// - Returns: HttpResponseError Object.
    
    private class func handleError(_ error: AFError) -> Error {
        return error
    }
}

extension Request {
    
    public func debugLog() -> Self {
        
        print("===============")
        print(self)
        print("Headers ---> ")
        print(self.request?.allHTTPHeaderFields ?? "")
        print("Body ---> ")
        if let requestBody = self.request?.httpBody {
            print(NSString(data: requestBody, encoding: String.Encoding.utf8.rawValue) ?? "")
        }
        print("===============")
        
        return self
    }
    
}
