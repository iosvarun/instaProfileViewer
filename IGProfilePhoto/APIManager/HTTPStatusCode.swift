//
//  HTTPStatusCode.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

@objc public enum HTTPStatusCode: Int {

    /// OK: 200
    ///
    @objc(HTTPStatusCodeOK)
    case ok = 200
    
    /// Created: 201
    ///
    case created = 201
    
    /// Accepted: 202
    ///
    case accepted = 202
    
    /// No Content: 204
    ///
    case noContent = 204

    
    // Bad Request: 400
    ///
    case badRequest = 400

    /// Unauthorized: 401
    ///
    case unauthorized = 401
    
    /// Forbidden: 403
    ///
    case forbidden = 403
    
    /// Request Timeout: 408
    ///
    case requestTimeout = 408

    /// Unprocessable Entity: 422
    ///
    case unprocessableEntity = 422
    
    /// Internal Server Error: 500
    case internalServerError = 500
    case NotImplemented
    case BadGateway
    case ServiceUnavailable
    case GatewayTimeout
    case HTTPVersionNotSupported
    case VariantAlsoNegotiates
    case InsufficientStorage
    case LoopDetected
    case NotExtended = 510
    case NetworkAuthenticationRequired
    
}
