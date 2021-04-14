//
//  AppDelegateExt.swift
//  DirectMessage
//
//  Created by Varun Kumar on 03/03/21.
//

import Foundation
import UIKit
import Firebase
//import UserNotifications

extension AppDelegate{
    
    //MARK: - Register Push notification
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        NotificationHandler.shared.deviceToken = deviceToken.map({String(format: "%02.2hhx", $0)}).joined()
        print("Push Token: " + NotificationHandler.shared.deviceToken)
        
        Messaging.messaging().apnsToken = deviceToken
        
        // Set delegate UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().delegate = self
        
        //Call only if MoEngageAppDelegateProxyEnabled is NO
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
        
        //Call only if MoEngageAppDelegateProxyEnabled is NO
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    //MARK: - Handle Push notification
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        
        //Custom Handling of notification if Any
        let pushDictionary = notification.request.content.userInfo
        print("willPresent notification pushDictionary\(pushDictionary)")
        
        if let type = pushDictionary["type"] as? String, type == "LocalNotification" {
            print("LocalNotification willPresent")
//            NotificationModel.deleteNotification(cid: ((pushDictionary["moengage"] as! [AnyHashable: Any])["cid"] as! String))
        }
        updateIconBadgeCount()
        //This is to only to display Alert and enable notification sound
        completionHandler([.alert, .sound]) // blank array will not presnt notification if app in foreground.
    }
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Handle push notification once received
        //Call only if MoEngageAppDelegateProxyEnabled is NO
        
        //Custom Handling of notification if Any
        let pushDictionary = response.notification.request.content.userInfo
        print("didReceive notification pushDictionary \(pushDictionary)")
        
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            if NotificationHandler.shared.isAppOpened {
                NotificationHandler.shared.customPushHandler(pushDictionary)
            }
        } else if response.actionIdentifier == "MOE_DISMISS_ACTION" || response.actionIdentifier == UNNotificationDismissActionIdentifier  {
            // Don't call customPushHandler
        }
        
        if let type = pushDictionary["type"] as? String, type == "LocalNotification" {
            print("LocalNotification didReceive")
        }
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "NotificationIsAboutToReceive")))
        updateIconBadgeCount()
        // Should be called once all the operation completed, tells the apploication that notification task has been perfomrmed.
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func runAfterDelay(_ delay: Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func updateIconBadgeCount() {
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}
