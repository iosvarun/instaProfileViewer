//
//  AppUtils.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import UIKit

struct AppUtils {
        
    
    static func setAppInstalled(_ appInstalled: Int){
        UserDefaultsUtil.setInt(appInstalled, key: UserDefaultsUtil.ReservedKey.appInstalled)
    }
    
    static func getAppInstalled() -> Int? {
        let uuid = UserDefaultsUtil.getInt(UserDefaultsUtil.ReservedKey.appInstalled)
        return uuid
    }
    
    static func setAppLaunched(_ appLaunched: Bool) {
        UserDefaultsUtil.setBool(appLaunched, key: UserDefaultsUtil.ReservedKey.appInstalled)
    }
    
    static func getAppLaunched() -> Bool? {
        let uuid = UserDefaultsUtil.getBool(UserDefaultsUtil.ReservedKey.appInstalled)
        return uuid
    }
    
    static func setAppRatingCount(_ appInstalled: Int){
        UserDefaultsUtil.setInt(appInstalled, key: UserDefaultsUtil.ReservedKey.appRating)
    }
    
    static func getAppRatingCount() -> Int? {
        let uuid = UserDefaultsUtil.getInt(UserDefaultsUtil.ReservedKey.appRating)
        return uuid
    }
    
    static func setOnboardingLaunch(_ onBoarding: Bool) {
        UserDefaultsUtil.setBool(onBoarding, key: UserDefaultsUtil.ReservedKey.onboardingLaunched)
    }
    
    static func getOnboardingLaunch() -> Bool {
        let uuid = UserDefaultsUtil.getBool(UserDefaultsUtil.ReservedKey.onboardingLaunched)
        return uuid
    }
    
    static func setAdMobAdDisplayCount(_ adMobCount: Int){
        UserDefaultsUtil.setInt(adMobCount, key: UserDefaultsUtil.ReservedKey.adMobAdDisplayCount)
    }
    
    
    static func getAdMobAdDisplayCount() -> Int? {
        let uuid = UserDefaultsUtil.getInt(UserDefaultsUtil.ReservedKey.adMobAdDisplayCount)
        return uuid
    }
    
    
}
