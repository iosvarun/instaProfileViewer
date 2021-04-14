//
//  FirebaseManager.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAnalytics

class FirebaseManager {
    static let shared = FirebaseManager()
    
    func sendAppUpdateEventToFireBase() {
        Analytics.logEvent("first_open", parameters: nil)
/*
        if (UserDefaults.standard.value(forKey: APP_VERSION) == nil) {
            Analytics.logEvent("first_open", parameters: nil)
            return
        }
        
        if(AppUtility.getAppVersion() != (UserDefaults.standard.value(forKey: APP_VERSION) as! String)){
            Analytics.logEvent("app_update", parameters: nil)
        }
 */
    }
    
    func trackFireBaseEvent(_ name: String, attributes: NSMutableDictionary?) {
        
        attributes?.setValue(AppUtility.deviceModel(), forKey: AnalyticsConstants.UserAttributes.DEVICE_MODEL)
        attributes?.setValue(AnalyticsConstants.UserConstants.APPLE, forKey: AnalyticsConstants.UserAttributes.DEVICE_MANUFACTURER)
        attributes?.setValue(AppUtility.osVersion(), forKey: AnalyticsConstants.UserAttributes.OS_VERSION)
        attributes?.setValue(AnalyticsConstants.UserConstants.IOS, forKey: AnalyticsConstants.UserAttributes.DEVICE_PLATFORM)
        
        if let dicAttribute = attributes {
            for (key, value) in dicAttribute {
                if value is String {
                    
                    if value as! String == "" {
                        dicAttribute.removeObject(forKey: key)
                    }
                }
            }
            print("The Firebase analytics event name is:- ", name)
            print("The Firebase analytics parameters are:- ", dicAttribute)
            Analytics.logEvent(name, parameters: (dicAttribute as! [String : Any]))
        }
    }
    
    func setUserAttributes() {
        
        Analytics.setUserProperty(AppUtility.deviceModel(), forName: AnalyticsConstants.UserAttributes.DEVICE_MODEL)
        Analytics.setUserProperty(AnalyticsConstants.UserConstants.APPLE , forName: AnalyticsConstants.UserAttributes.DEVICE_MANUFACTURER )
        Analytics.setUserProperty(AppUtility.osVersion()  , forName: AnalyticsConstants.UserAttributes.OS_VERSION)
    }
    
    
}
