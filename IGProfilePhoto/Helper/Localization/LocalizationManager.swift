//
//  KPLocalizationManager.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import UIKit

func localized(key: String, comment: String) -> String  {
    return LocalizationManager.sharedInstance.localizedStringForKey(key: key, comment: comment)
}

func getAppLanguage() -> String {
    return LocalizationManager.sharedInstance.getLanguage()
}

func setAppLanguage(languageCode: String) {
    LocalizationManager.sharedInstance.setLanguage(languageCode: languageCode)
}

class LocalizationManager: NSObject {
    
    var bundle: Bundle!
    
    class var sharedInstance: LocalizationManager {
        struct Singleton {
            static let instance: LocalizationManager = LocalizationManager()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        bundle = Bundle.main
        let language = getLanguage()
        if language != languageNone {
            if let languageDirectoryPath = Bundle.main.path(forResource: language, ofType: "lproj")  {
                bundle = Bundle.init(path: languageDirectoryPath)
            }
        }
    }
    
    func localizedStringForKey(key: String, comment: String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }
    
    //MARK:- setLanguage
    // Sets the desired language of the ones you have.
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
    func setLanguage(languageCode:String) {
        UserDefaults.standard.set(languageCode, forKey: "currentLanguage")
        UserDefaults.standard.synchronize()
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
    }
    
    //MARK:- resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    //MARK:- getLanguage
    // Just gets the current setted up language.
    func getLanguage() -> String {
        guard let appleLanguages = UserDefaults.standard.string(forKey: "currentLanguage")
            else {
                return "none"
        }
        return appleLanguages
    }
    
}
