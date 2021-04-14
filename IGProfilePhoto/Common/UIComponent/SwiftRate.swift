//
//  SwiftAlert.swift
//  DirectMessage
//
//  Created by Varun Kumar on 31/03/21.
//

import Foundation
import UIKit


public class SwiftRate: NSObject {
    
    public static var shared = SwiftRate()

    public static var appID: String?
    public static var alertTitle: String?
    public static var showLaterButton: Bool = true

    public static var alertMessage: String?
    public static var alertCancelTitle: String?
    public static var alertRateTitle: String?
    public static var alertRateLaterTitle: String?
    public static var appName: String?

    public static func rateApp(host: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) {
        NSLog("[SwiftRater] Trying to show review request dialog.")
        SwiftRate.shared.showRatingAlert(host: host)
    }
    
    
    
    private static var appVersion: String {
        get {
            return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0.0"
        }
    }

    private var titleText: String {
//        return SwiftRate.alertTitle ?? String.init(format: localize("Rate %@"), mainAppName)
        return SwiftRate.alertTitle ?? String.init(format: "Rate %@", mainAppName)

    }

    private var messageText: String {
//        return SwiftRate.alertMessage ?? String.init(format: localize("Rater.title"), mainAppName)
        return SwiftRate.alertMessage ?? String.init(format: "If you enjoy using %@, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!", mainAppName)

    }

    private var rateText: String {
//        return SwiftRate.alertRateTitle ?? String.init(format: localize("Rate %@"), mainAppName)
        return SwiftRate.alertRateTitle ?? String.init(format: "Rate %@", mainAppName)

    }

    private var cancelText: String {
//        return SwiftRate.alertCancelTitle ?? String.init(format: localize("No, Thanks"), mainAppName)
        return SwiftRate.alertCancelTitle ?? String.init(format: "No, Thanks", mainAppName)

    }

    private var laterText: String {
//        return SwiftRate.alertRateLaterTitle ?? String.init(format: localize("Remind me later"), mainAppName)
        return SwiftRate.alertRateLaterTitle ?? String.init(format: "Remind me later", mainAppName)

    }

    private func localize(_ key: String) -> String {
        return NSLocalizedString(key, tableName: "SwiftRaterLocalization", bundle: Bundle.module, comment: "")
    }
    
    private var mainAppName: String {
        if let name = SwiftRate.appName {
            return name
        }
        if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return name
        } else if let name = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return name
        } else {
            return "App"
        }
    }
    
    func showRatingAlert(host: UIViewController?) {
        
            let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
            
            let rateAction = UIAlertAction(title: rateText, style: .default, handler: {
                [unowned self] action -> Void in
                self.rateAppWithAppStore()
//                UsageDataManager.shared.isRateDone = true
            })
            alertController.addAction(rateAction)
            
            if SwiftRate.showLaterButton {
                alertController.addAction(UIAlertAction(title: laterText, style: .default, handler: {
                    action -> Void in
//                    UsageDataManager.shared.saveReminderRequestDate()
                }))
            }
            
            alertController.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: {
                action -> Void in
//                UsageDataManager.shared.isRateDone = true
            }))
            
            if #available(iOS 9.0, *) {
                alertController.preferredAction = rateAction
            }
            
            host?.present(alertController, animated: true, completion: nil)
    }
    
    private func rateAppWithAppStore() {
        #if arch(i386) || arch(x86_64)
        print("APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
        #else
        // "itms-apps://itunes.apple.com/gb/app/id\(appId)?action=write-review&mt=8"
        guard let appId = SwiftRate.appID else { return }
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review") {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                                        (success) in
                                        print("rateAppWithAppStore : \(success)")
                                      })
        }
        #endif
    }
}


extension Bundle {
    static var module: Bundle {
        Bundle(for: SwiftRate.self)
    }
}
