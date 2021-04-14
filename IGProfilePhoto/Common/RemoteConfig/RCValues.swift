//
//  RCValues.swift
//  DirectMessage
//
//  Created by Varun Kumar on 31/03/21.
//

import Foundation
import Firebase

enum ValueKey: String {
    case appPrimaryColor
    case showBannerAd
    case showCount
    case customText
    case showCustomRating
    case showGoogleAds
    case showInterstitialAd
    case showRewardInterstitial
    case showRewardedAd
    case closeInAppScreen
    case appVersion

}


class RCValues {
    static let sharedInstance = RCValues()
    var loadingDoneCallback: (() -> Void)?
    var fetchComplete = false
    
    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.appPrimaryColor.rawValue : "#FBB03B",
            ValueKey.showBannerAd.rawValue: false,
            ValueKey.showCount.rawValue: 2,
            ValueKey.customText.rawValue: "Subscribe",
            ValueKey.showCustomRating.rawValue: false,
            ValueKey.showInterstitialAd.rawValue: false,
            ValueKey.showRewardInterstitial.rawValue: false,
            ValueKey.showRewardedAd.rawValue: false,
            ValueKey.showGoogleAds.rawValue: false,
            ValueKey.closeInAppScreen.rawValue: true,
            ValueKey.appVersion.rawValue : "1.0.2",

        ]
        
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        // WARNING: Don't actually do this in production!
        settings.minimumFetchInterval = 0 // 43200
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() {
        // 1
        activateDebugMode()
        
        // 2
        RemoteConfig.remoteConfig().fetch { [weak self] _, error in
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                // In a real app, you would probably want to call the loading
                // done callback anyway, and just proceed with the default values.
                // I won't do that here, so we can call attention
                // to the fact that Remote Config isn't loading.
                return
            }
            
            // 3
            RemoteConfig.remoteConfig().activate { [weak self] _, _ in
              print("Retrieved values from the cloud!")
              self?.fetchComplete = true
              DispatchQueue.main.async {
                self?.loadingDoneCallback?()
              }
            }
        }
    }
    
    func color(forKey key: ValueKey) -> UIColor {
        let colorAsHexString = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFF"
        let convertedColor = UIColor(hexString: colorAsHexString)!
        return convertedColor
    }
    
    func bool(forKey key: ValueKey) -> Bool {
      RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }

    func string(forKey key: ValueKey) -> String {
      RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }

    func double(forKey key: ValueKey) -> Double {
      RemoteConfig.remoteConfig()[key.rawValue].numberValue.doubleValue
    }

    func int(forKey key: ValueKey) -> Int {
        RemoteConfig.remoteConfig()[key.rawValue].numberValue.intValue
    }
    
}
