//
//  AppDelegate.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 10/04/21.
//

import UIKit
import IQKeyboardManager
import Firebase
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #warning("delete this when need to disable the firebase analytics")
        /// From here
        var newArguments = ProcessInfo.processInfo.arguments
        newArguments.append("-FIRAnalyticsDebugEnabled")
        ProcessInfo.processInfo.setValue(newArguments, forKey: "arguments")
        NotificationHandler.shared.registerPushNotification(for: application)
        
        FirebaseApp.configure()
        _ = RCValues.sharedInstance

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        let dic = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.composePage(), attributes: dic)
        
        IQKeyboardManager.shared().isEnabled = true
        if !AppUtils.getAppLaunched()! {
            AppUtils.setAppLaunched(true)
            print("appLaunched did nt launch ")
//            CustomMessage.storeMessage(messageId: 1, messageTxt: "Hello", messageTitle: "Hello")
//            CustomMessage.storeMessage(messageId: 2, messageTxt: "How are you", messageTitle: "How are you")
//            CustomMessage.storeMessage(messageId: 3, messageTxt: "I'm on my way", messageTitle: "On way")
//            CustomMessage.storeMessage(messageId: 4, messageTxt: "Is it good time to talk?", messageTitle: "Talk")
//            CustomMessage.storeMessage(messageId: 5, messageTxt: "", messageTitle: "Home Address")
//            CustomMessage.storeMessage(messageId: 6, messageTxt: "", messageTitle: "Business Address")
            FirebaseManager.shared.sendAppUpdateEventToFireBase()
        }else{
            print("appLaunched")
        }
    
        // Override point for customization after application launch.
//        SKPaymentQueue.default().add(IAPService.instance)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

