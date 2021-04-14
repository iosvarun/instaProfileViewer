//
//  UserDefaultsUtil.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

struct UserDefaultsUtil {
    
    enum ReservedKey: String {
        case deviceTypeID
        case mobileNo
        case operatorNumber
        case appInstalled
        case appLaunched
        case appRating
        case onboardingLaunched
        case adMobAdDisplayCount
        case authCode
        case token

    }
    
    public static func getBool(_ key: ReservedKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    public static func setBool(_ value: Bool, key: ReservedKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public static func setInt(_ value: Int, key: ReservedKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public static func getInt(_ key: ReservedKey) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    public static func getString(_ key: ReservedKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    public static func setString(_ value: String, key: ReservedKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    public static func getDate(_ key: ReservedKey) -> Date? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key.rawValue) as? Date
    }
    
    public static func setDate(_ value: Date, key: ReservedKey) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    public static func setObject(_ value: NSCoding, key: ReservedKey) {
        let encoded = NSKeyedArchiver.archivedData(withRootObject: value)
        
        UserDefaults.standard.set(encoded, forKey: key.rawValue)
    }
    
    public static func getObject(forKey key: ReservedKey) -> AnyObject? {
        if let encoded = UserDefaults.standard.object(forKey: key.rawValue) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: encoded) as AnyObject
        }
        
        return nil
    }
    
    public static func setArray(_ value: [Any], key: ReservedKey) {
        let encoded = NSKeyedArchiver.archivedData(withRootObject: value)
        
        UserDefaults.standard.set(encoded, forKey: key.rawValue)
    }
    
    public static func getArray(forKey key: ReservedKey) -> [Any]? {
        if let encoded = UserDefaults.standard.object(forKey: key.rawValue) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: encoded) as? [Any]
        }
        
        return nil
    }
    
    public static func clearUserDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}
