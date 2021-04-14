//
//  SearchParseHandler.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 13/04/21.
//

import Foundation

class SearchParseHandler {
 
    func parse<T: Codable>(data: Data, completionHandler: ((T?, CRError?)->())?){
        do {
        let callRecodsListResponse = try T.decode(from: data)
        print("topsearch register \(callRecodsListResponse)")
        completionHandler?(callRecodsListResponse, nil)
        }catch {
            completionHandler?(nil, CRError.error(error))
        }
    }
}
