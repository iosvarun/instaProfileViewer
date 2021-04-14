//
//  SearchAPIHandler.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 13/04/21.
//

import Foundation

class SearchAPIHandler {
    
    func topSearchUser(params: [String: Any],  userName: String,  completionHandler: ((Data?, CRError?)->())?) {
        InstaRecoderService.searchUser(params, searchText: userName, headers: [:]) { [weak self] (response) in
            if let data = response as? Data {
                do {
                    completionHandler?(data, nil)

                }catch {
                    completionHandler?(nil, CRError.error(error))
                }
            }
        } errorCallback: { (error) in
            completionHandler?(nil, CRError.error(error))
        } networkErrorCallback: {
            completionHandler?(nil, CRError.noInternet)
        }
    }
    
}
