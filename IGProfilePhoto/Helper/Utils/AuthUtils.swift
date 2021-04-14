//
//  AuthUtils.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

struct AuthUtils {
    
    static func setAuthCode(_ authCode: String){
        UserDefaultsUtil.setString(authCode, key: UserDefaultsUtil.ReservedKey.authCode)
    }
    
    static func getAuthCode() -> String? {
        let authCode = UserDefaultsUtil.getString(UserDefaultsUtil.ReservedKey.authCode)
        return authCode
    }
    
    static func setAuthToken(_ token: String){
        UserDefaultsUtil.setString(token, key: UserDefaultsUtil.ReservedKey.token)
    }
    
    static func getAuthToken() -> String? {
        let token = UserDefaultsUtil.getString(UserDefaultsUtil.ReservedKey.token)
        return token
    }

}
