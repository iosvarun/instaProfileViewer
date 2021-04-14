//
//  APIParams.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

class APIParams: NSObject {
    
    // convert dict to Data
    class func convertDictonaryToData(parameters: NSDictionary) -> Data {
        let urlParams = parameters.compactMap({ (key, value) -> String in return "\(key)=\(value)" }).joined(separator: "&")
        let postData = Data(urlParams.utf8)
        return postData
    }
    
    // CommonParameter for API call for post call
    class func dictionaryWithCommonParameter(user_id: String?) -> (NSMutableDictionary) {
//        guard let userId = user_id else {
//            let commonParams: NSMutableDictionary = ["meta": ["app_version": AppUtils.appVersion,
//                                                                 "store": AppUtils.store,
//                                                                 "app_build": AppUtils.appBuild]]
//               return commonParams
//        }
//
//        let commonParams: NSMutableDictionary = ["meta": ["app_version": AppUtils.appVersion,
//                                                          "store": AppUtils.store,
//                                                          "app_build": AppUtils.appBuild,
//                                                          "user_id": userId]]
        let commonParams: NSMutableDictionary =  ["": ""]
        return commonParams
    }
    
    class func generateTokenParam (user_id: String?) -> NSMutableDictionary {
        let parameters: NSMutableDictionary = dictionaryWithCommonParameter(user_id: user_id) as NSMutableDictionary
//        parameters = ["params": ["uuid": AppUtils.uuid]]
        return parameters
    }
    
}
