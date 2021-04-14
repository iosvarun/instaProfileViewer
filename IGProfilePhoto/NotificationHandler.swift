//
//  NotificationHandler.swift
//  CallRecoder
//
//  Created by Varun Kumar on 24/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class NotificationHandler: NSObject {

    var deviceToken = ""       // Device Token updated after register push notification
    var isAppOpened: Bool = false
    var isNotificationAllowed = false

    static let shared = NotificationHandler()
    
    private override init() {
    }
    
    // This method initiate the registration process with Apple Push Notification service. If registration succeeds, the app calls your app delegate object’s application(_:didRegisterForRemoteNotificationsWithDeviceToken:) method and passes it a device token. You should pass this token along to the server you use to generate remote notifications for the device.
    func registerPushNotification(for application: UIApplication) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("permission granted: \(granted)")
            guard granted else {
                return
            }
            self.getNotificationSettings()
            self.isNotificationAllowed = granted
            Messaging.messaging().delegate = self

//            AppUtils.setNotificationEnabled(granted == true ? true : false)
//            DispatchQueue.main.async {
//                application.registerForRemoteNotifications()
//            }
        }
        // Set app is opened
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isAppOpened = true
        }
    }
    
 // (in case user declines the permissions) This method returns the settings the user has granted
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    // MARK: - Methods Related
    // MARK: - Local Notification
    
    func addEveningLocalNotification() {
        DispatchQueue.main.async {
            // Create Notification Content
            let notificationContent = UNMutableNotificationContent()

            // Configure Notification Content
            notificationContent.title = "Direct Message"
            notificationContent.body = "Send whatsapp message without save number."
            notificationContent.sound = UNNotificationSound.default
            notificationContent.categoryIdentifier = "alarm"
            notificationContent.userInfo = ["type": "LocalNotification"]

            var dateComponents = DateComponents()
            dateComponents.hour = 15
            dateComponents.minute = 00
            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // Add Trigger
//            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

            // Create Notification Request
            let notificationRequest = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: notificationTrigger)

            // Add Request to User Notification Center
            UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                if let error = error {
                    print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                }
            }
        }
    }
    
    func addMorningLocalNotification() {
        var weekDay = self.getDayOfWeek()
     
        switch weekDay {
        case 1:
            weekDay = 4
        case 2:
            weekDay = 5
        case 3:
            weekDay = 6
        case 4:
            weekDay = 7
        case 5:
            weekDay = 1
        case 6:
            weekDay = 2
        case 7:
            weekDay = 3
        default:
            weekDay = 2
        }
        
        DispatchQueue.main.async {
            // Create Notification Content
            let notificationContent = UNMutableNotificationContent()

            // Configure Notification Content
            notificationContent.title = "Direct Message"
            notificationContent.body = "Good Afternoon, Grow your business with whatsapp marketing"
            notificationContent.sound = UNNotificationSound.default
            notificationContent.categoryIdentifier = "alarm"
            notificationContent.userInfo = ["type": "LocalNotification"]

            var dateComponents = DateComponents()
            dateComponents.weekday = weekDay
            dateComponents.hour = 15
            dateComponents.minute = 00
            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // Add Trigger
//            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

            // Create Notification Request
            let notificationRequest = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: notificationTrigger)

            // Add Request to User Notification Center
            UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                if let error = error {
                    print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                }
            }
        }
    }
        
    
    // MARK: - Handle Push Messages
    /*
     * Custom Push handler
     */
    func customPushHandler(_ userInfo : [AnyHashable : Any]) {
        print("User Info in CustomPushHandler: \(userInfo)")

//        let aps = userInfo["aps"] as? [String: AnyObject]
//        print("aps Info: \(String(describing: aps))")

        guard let aps = userInfo["aps"] as? [String: Any] ,
                      let alert = aps["alert"] as? [String: Any] ,
                      let body = alert["body"] as? String ,
                      let title = alert["title"] as? String else  {

                    return
                }
        print("Body is \(body) Title is \(title)")


        if let removeAdKey = userInfo["removeAdKey"] {
            print("removeAdKey value  \(removeAdKey)")
        }
        
        if let titleKey = userInfo["titleKey"] {
            print("titleKey value \(titleKey)")
        }
        
        if let messageKey = userInfo["messageKey"] {
            print("messageKey value \(messageKey)")
        }



        /*

        print("User Info in CustomPushHandler: \(userInfo)")
        if let app_extra_dict = userInfo["app_extra"] as? Dictionary<String,Any>,
            let pushDict = app_extra_dict["screenData"] as? Dictionary<String,Any>,
            let screenPushData = pushDict["DLDATA"] as? String {
            if let pushDataDic = screenPushData.convertToDictionary() {
                navigateViaDeeplink(screenPushData: pushDataDic)
            } else {
                if screenPushData.isEmpty {
                    navigateInvalidDeeplink(error: nil)
                } else {
                    navigateInvalidDeeplink(error: APIErrorCode.deepLink)
                    /*let emptyJson = "{}"
                    if let pushDataDic = emptyJson.convertToDictionary() {
                        navigateViaDeeplink(screenPushData: pushDataDic)
                    } else {
                        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
                        let errorCode = "[" + "\(KPAPIPrefix.deepLink)" + "-" + "\(APIErrorCode.deepLink)" + "]"
                        window?.makeToast("Message error".localized+"\n" + errorCode)
                        KPUtility.sendDeepLinkErrorAnalytics(message: "Message error".localized, code: errorCode)
                    }*/
                }
            }
        } else if let app_extra_dict = userInfo["app_extra"] as? Dictionary<String,Any>,
            let pushDict = app_extra_dict["screenData"] as? Dictionary<String,Any>,
            let screenPushData = pushDict["DLDATA"] as? Dictionary<String,Any> {
            navigateViaDeeplink(screenPushData: screenPushData)
        } else if let app_extra_dict = userInfo["app_extra"] as? Dictionary<String,Any>,
            let pushDict = app_extra_dict["screenData"] as? String {
            if let pushDataDic = pushDict.convertToDictionary() {
                guard let pushData = pushDataDic["ScreenName"] as? String, !pushData.isEmpty
                    else { return navigateInvalidDeeplink(error: nil)}
                navigateViaDeeplink(screenPushData: pushDataDic)
            }
            let emptyJson = "{}"
            if let pushDataDic = emptyJson.convertToDictionary() {
                navigateViaDeeplink(screenPushData: pushDataDic)
            } else {
                let window = (UIApplication.shared.delegate as? AppDelegate)?.window
                let errorCode = "[" + "\(APIPrefix.deepLink)" + "-" + "\(APIErrorCode.deepLink)" + "]"
                window?.makeToast(MESSAGE_ERROR + "\n" + errorCode)
//                KPUtility.sendDeepLinkErrorAnalytics(message: MESSAGE_ERROR.localized, code: errorCode)
            }
        } else if let app_extra_dict = userInfo["app_extra"] as? Dictionary<String,Any>,
            let pushDict = app_extra_dict["screenData"] as? Dictionary<String,Any> {
            guard let pushData = pushDict["ScreenName"] as? String, !pushData.isEmpty
                else { return navigateInvalidDeeplink(error: nil)}
            navigateViaDeeplink(screenPushData: pushDict)
        } else if let dataDic = userInfo as? [String : Any] {
            navigateViaDeeplink(screenPushData: dataDic)
        }
 */
    }
    
    
    /*
     * Navigate via deep linking
     */
    func navigateViaDeeplink(screenPushData: [String: Any]) {
        /*
        let deeplinkManager = PushDeeplinkManager.init()
        if let dataModel =  deeplinkManager.createDeepLinkModel(pushDataDict: screenPushData) {
            deeplinkManager.deepLinkNotificationToView(deepLinkModel: dataModel)
        }
 */
    }
    
    func navigateInvalidDeeplink(error: String?) {
        /*
        let deeplinkManager = PushDeeplinkManager.init()
        deeplinkManager.invalidDeepLink(errorCodeString: error)
 */
    }
    
    func getDayOfWeek() -> Int? {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDateString: String = formatter.string(from: date)
        guard let todayDate = formatter.date(from: currentDateString) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
}

extension NotificationHandler: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

