//
//  AnalyticsConstants.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

struct AnalyticsConstants {
    
    struct UserAttributes {
        static let DEVICE_PLATFORM = "DEVICE_PLATFORM"
        static let DEVICE_MODEL = "DEVICE_MODEL"
        static let OS_VERSION   = "OS_VERSION"
        static let DEVICE_MANUFACTURER = "DEVICE_MANUFACTURER"
    }
    
    struct UserConstants {
        static let IOS   = "iOS"
        static let GUEST = "GUEST"
        static let APPLE = "APPLE"
    }
    
    struct EventKey {
        static let COMPOSE_PAGE = "COMPOSE_PAGE"
        static let CUSTOM_MESSAGE_PAGE = "CUSTOM_MESSAGE_PAGE"
        static let HISTORY_PAGE = "HISTORY_PAGE"
        static let SETTINGS_PAGE = "SETTINGS_PAGE"
        static let CREATE_NEW_CUSTOM_MESSAGE_PAGE = "CREATE_NEW_CUSTOM_MESSAGE_PAGE"
        static let FAQ_PAGE = "FAQ_PAGE"
        static let TERMS_AND_CONDITIONS_PAGE = "TERMS_AND_CONDITIONS_PAGE"
        static let PRIVACY_POLICY_PAGE = "PRIVACY_POLICY_PAGE"
        static let SEND_VIA_WHATSAPP = "SEND_VIA_WHATSAPP"
        static let SEND_VIA_IPHONE_MESSGEAPP = "SEND_VIA_IPHONE_MESSGEAPP"
        static let SELECT_CUSTOM_MESSAGE = "SELECT_CUSTOM_MESSAGE"
        static let UPDATE_CUSTOM_MESSAGE = "UPDATE_CUSTOM_MESSAGE"
        static let DELETE_CUSTOM_MESSAGE = "DELETE_CUSTOM_MESSAGE"
        
        static let DELETE_HISTORY = "DELETE_HISTORY"
        static let CREATE_NEW_CUSTOM_MESSAGE = "CREATE_NEW_CUSTOM_MESSAGE"
        static let SAVE_NEW_CUSTOM_MESSAGE = "SAVE_NEW_CUSTOM_MESSAGE"

        static let CONTACT_US = "CONTACT_US"
        static let RATE_APP = "RATE_APP"
        static let SHARE_APP = "SHARE_APP"
        static let FAQ = "FAQ"
        static let PRIVACY_POLICY = "PRIVACY_POLICY"
        static let TERMS_AND_CONDITION = "TERMS_AND_CONDITION"
        static let REMOVE_AD = "REMOVE_AD"


    }
    
    struct EventAttributes {
        static let PHONE_NUMBER = "PHONE_NUMBER"
        static let MESSAGE = "MESSAGE"
        static let MESSAGE_TITLE = "MESSAGE_TITLE"
    }
}


public class AnalyticsUserAttributes : NSObject {
    class func devicePlatform() -> String { return AnalyticsConstants.UserAttributes.DEVICE_PLATFORM }
    class func deviceOSVersion() -> String { return AnalyticsConstants.UserAttributes.OS_VERSION }
    class func deviceModel() -> String { return AnalyticsConstants.UserAttributes.DEVICE_MODEL }
    class func deviceManufacturer() -> String { return AnalyticsConstants.UserAttributes.DEVICE_MANUFACTURER }
}

public class AnalyticsEventKey : NSObject {
    class func composePage() -> String { return AnalyticsConstants.EventKey.COMPOSE_PAGE }
    class func customMessagePage() -> String { return AnalyticsConstants.EventKey.CUSTOM_MESSAGE_PAGE }
    class func historyPage() -> String { return AnalyticsConstants.EventKey.HISTORY_PAGE }
    class func settingsPage() -> String { return AnalyticsConstants.EventKey.SETTINGS_PAGE }
    class func createNewCustomMessagePage() -> String { return AnalyticsConstants.EventKey.CREATE_NEW_CUSTOM_MESSAGE_PAGE }
    class func faqPage() -> String { return AnalyticsConstants.EventKey.FAQ_PAGE }
    class func termsAndConditionsPage() -> String { return AnalyticsConstants.EventKey.TERMS_AND_CONDITIONS_PAGE }
    class func privacyPolicyPage() -> String { return AnalyticsConstants.EventKey.PRIVACY_POLICY_PAGE }
    class func sendViaWhatsapp() -> String { return AnalyticsConstants.EventKey.SEND_VIA_WHATSAPP }
    class func sendViaiPhoneMessageApp() -> String { return AnalyticsConstants.EventKey.SEND_VIA_IPHONE_MESSGEAPP }
    class func selectCustomMessage() -> String { return AnalyticsConstants.EventKey.SELECT_CUSTOM_MESSAGE }
    class func updateCustomMessage() -> String { return AnalyticsConstants.EventKey.UPDATE_CUSTOM_MESSAGE }
    class func deleteCustomMessage() -> String { return AnalyticsConstants.EventKey.DELETE_CUSTOM_MESSAGE }

    class func saveNewCustomMessage() -> String { return AnalyticsConstants.EventKey.SAVE_NEW_CUSTOM_MESSAGE }
    class func deleteHistory() -> String { return AnalyticsConstants.EventKey.DELETE_HISTORY }
    class func createNewCustomMessage() -> String { return AnalyticsConstants.EventKey.CREATE_NEW_CUSTOM_MESSAGE }
    class func contactUs() -> String { return AnalyticsConstants.EventKey.CONTACT_US }
    class func rateApp() -> String { return AnalyticsConstants.EventKey.RATE_APP }
    class func shareApp() -> String { return AnalyticsConstants.EventKey.SHARE_APP }
    class func faq() -> String { return AnalyticsConstants.EventKey.FAQ }
    class func privacyPolicy() -> String { return AnalyticsConstants.EventKey.PRIVACY_POLICY }
    class func termsAndCondition() -> String { return AnalyticsConstants.EventKey.TERMS_AND_CONDITION }
    class func removeAd() -> String { return AnalyticsConstants.EventKey.REMOVE_AD }
}


public class AnalyticsEventAttributes : NSObject {
    class func phoneNumber() -> String { return AnalyticsConstants.EventAttributes.PHONE_NUMBER }
    class func message() -> String { return AnalyticsConstants.EventAttributes.MESSAGE }
    class func messageTitle() -> String { return AnalyticsConstants.EventAttributes.MESSAGE_TITLE}
}

