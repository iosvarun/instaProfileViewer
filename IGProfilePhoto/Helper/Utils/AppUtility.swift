//
//  AppUtility.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import UIKit
import DeviceGuru
import StoreKit

class AppUtility: NSObject {
    
    class func deviceModel() -> String {
        let deviceGuru = DeviceGuru()
        let deviceName = deviceGuru.hardwareDescription()
        return deviceName ?? ""
    }
    
    class func typeOfUser() -> String {
        let strUserType = ""
        return strUserType
    }
    
    class func osVersion() -> String {
        let Device = UIDevice.current
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        return String(iosVersion)
        
    }
    
    class func getAppVersion() -> String {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return version

//        let build: String = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
//        return version + "." + build
    }
    
    class func saveAppVersionToDefaults() {
        UserDefaults.standard.set(self.getAppVersion(), forKey: APP_VERSION)
        UserDefaults.standard.synchronize()
    }
    
    //MARK : - get the current selected language for get API call
    class func getParameterLanguageString() -> String {
        let currentLanguage = getAppLanguage() == languageEn ? "en-GB" : "vi-VN"
        return currentLanguage
    }
    
    class func convertDictonaryToData(parameters: NSDictionary) -> Data {
          let urlParams = parameters.compactMap({ (key, value) -> String in return "\(key)=\(value)" }).joined(separator: "&")
          let postData = Data(urlParams.utf8)
          return postData
      }
    
    class func toString(format: String, timeString: String) -> Date {
        let dateFormatter1 = DateFormatter()
//        dateFormatter1.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter1.dateFormat = format
        let date = dateFormatter1.date(from:timeString)!
        return date
    }

    class func getDayAndTime(timeString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        let toStringDate = toString(format: "yyyy-MM-dd HH:mm:ss", timeString: timeString)
        
        let dayTime = "\(dateFormatter.string(from: toStringDate))" + ", " + "\((timeFormatter.string(from: toStringDate)))"
        print(dayTime)
        return dayTime
    }
    
    class func showAlertForRecoder(withMessage message: String?, alertTitle: String, viewController: UIViewController) {
        DispatchQueue.main.async {
//            let dntAllowAction = UIAlertAction(title: "Don't Allow", style: .cancel, handler: nil)
//            let allowAction = UIAlertAction(title: "Allow", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            viewController.showAlert(alertTitle, message: message, actions: [okAction])
        }
    }
    
    class func getStringFromDate(date: Date, formatter: String = "yyyy-MM-dd'T'HH:mm:ss'Z'") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        let utcString = dateFormatter.string(from: date)
        return utcString
    }
    
    class func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            print("SKStoreReviewController")
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "id1557291502") {
            UIApplication.shared.openURL(url)
            print("UIApplication")
            
        }
    }
    
    class func toShowAppRating() {
        if let appRating = AppUtils.getAppRatingCount() {
            if appRating == 4 {
                AppUtility.rateApp()
                AppUtils.setAppRatingCount(0)
            }else {
                AppUtils.setAppRatingCount(appRating + 1)
            }
        }else{
            AppUtils.setAppRatingCount(0)
        }
    }
}
