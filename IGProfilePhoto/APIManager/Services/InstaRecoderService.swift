//
//  InstarecoderService.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 13/04/21.
//

import Foundation

import Alamofire

struct InstaRecoderService {
    
    
    static func searchUser(_ parameters: RequestBody,
                             searchText: String,
                               headers: RequestHeaders,
                               successCallback: @escaping ((_ response: Any?) -> Void),
                               errorCallback: @escaping ((_ error: Error) -> Void),
                               networkErrorCallback: @escaping (() -> Void)) {
        NetworkAdapter.request(BaseRouter.instaRecorderRouterManager(InstaRecoderRouter.searchUser(searchText))) { value in
            successCallback(value)
        } errorHandler: { error in
            print(error.localizedDescription)
            errorCallback(error)
        } networkErrorHandler: {
            networkErrorCallback()
        }
    }
    
    static func userChannel(_ parameters: RequestBody,
                             userName: String,
                               headers: RequestHeaders,
                               successCallback: @escaping ((_ response: Any?) -> Void),
                               errorCallback: @escaping ((_ error: Error) -> Void),
                               networkErrorCallback: @escaping (() -> Void)) {
        NetworkAdapter.request(BaseRouter.instaRecorderRouterManager(InstaRecoderRouter.userChannel(userName))) { value in
            successCallback(value)
        } errorHandler: { error in
            print(error.localizedDescription)
            errorCallback(error)
        } networkErrorHandler: {
            networkErrorCallback()
        }
    }
    
   

    
}
