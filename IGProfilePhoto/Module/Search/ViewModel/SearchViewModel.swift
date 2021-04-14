//
//  SearchViewModel.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 10/04/21.
//

import Foundation

class SearchViewModel {
    
    var users: [SearchUser]?

    var topSearchCompletioHandler: (([SearchUser]?, CRError?)->())?
    var apiHandler: SearchAPIHandler?
    var parseHandler: SearchParseHandler?
    
    init(apiHandler: SearchAPIHandler?, parseHandler: SearchParseHandler?) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
    }
    
    func topSearchuser(searchUserName: String, completionHandler: (([SearchUser]?, CRError?)->())?) {
        
        let params: QueryParams = [:]

        self.topSearchCompletioHandler = completionHandler
        
        apiHandler?.topSearchUser(params: params, userName: searchUserName, completionHandler: { (data, error) in
            print("error  \(String(describing: error))")
            if let error = error {
                completionHandler?(nil, error)
            }else {
                self.parseHandler?.parse(data: data!, completionHandler: { (response: TopSearchUserResponse?, error: CRError?) in
                    if let error = error {
                        completionHandler?(nil, error)
                    }else{
                        self.users = response?.user
                        completionHandler?(response!.user, nil)
                    }
                })
            }
        })
    }
    
}
