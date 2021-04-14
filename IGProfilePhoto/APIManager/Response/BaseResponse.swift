//
//  BaseResponse.swift
//  CallRecoder
//
//  Created by Varun Kumar on 12/3/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

protocol BaseResponse {
    
    var errorDetails: String? {get}
    var message: String? {get}
    var status: String? {get}
     var success: Bool? {get}
}

extension BaseResponse {
    
    var success: Bool? {
        return status == "800"
    }
}

