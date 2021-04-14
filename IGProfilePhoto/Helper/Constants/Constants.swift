//
//  Constants.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import UIKit


let IS_IPAD             = (UIDevice.current.userInterfaceIdiom == .pad ? true : false)
let IS_PORTRAIT         = (UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown)
let IS_LANDSCAPE        = (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight)
let APP_DELEGATE        = UIApplication.shared.delegate as! AppDelegate
// iPhone Screen Size
let SCREEN_WIDTH        = UIScreen.main.bounds.width
let SCREEN_HEIGHT       = UIScreen.main.bounds.height
let IPHONE_5S_WIDTH : CGFloat = 320.0
let IPHONE_8_PLUS_WIDTH : CGFloat = 414.0
let IPHONE_6_WIDTH : CGFloat = 375.0

let IPHONE_4_HEIGHT : CGFloat = 480.0
let IPHONE_5_HEIGHT : CGFloat = 568.0
let IPHONE_6_HEIGHT : CGFloat = 667.0
let IPHONE_6_PLUS_HEIGHT : CGFloat = 736.0
let IPHONE_X_XS_HEIGHT : CGFloat = 812.0
let IPHONE_XR_HEIGHT : CGFloat = 896.0

let APPSTORE_APP_ID = "1557291502"
let APPSTORE_APP_URL_STRING = "https://apps.apple.com/us/app/direct-message-for-whatsapp/id1557291502"

// MARK: – IAP Identifiers
let IAP_FULL_VERSION_AUTORENEW_MONTHLY = "com.varun.drctmsg.fullpackage_autorenew"
let IAP_FOOD_SUB_MONTHLY = "com.iapcourse.mealsmonthly"

// MARK: – Notification Identifiers
let IAPServicePurchaseNotification = "IAPServicePurchaseNotification"
let IAPServiceRestoreNotification = "IAPServiceRestoreNotification"
let IAPServiceFailureNotification = "IAPServiceFailureNotification"
let IAPSubscriptionInformationWasChangedNotification = "IAPSubscriptionInformationWasChangedNotification"

// MARK: – App Secrets
let appSecret = "cad4865e926e4f58a28bdd835ce6fb19"


// MARK: - Admob AD id
let REWARDEDAD_ADMOB_ID  = "ca-app-pub-7950371036228408/8261536116"
let INTERSTITAL_ADMOB_ID = "ca-app-pub-7950371036228408/7722124845"
let INTERSTITAL_REWARDEDAD_ADMOB_ID  = "ca-app-pub-7950371036228408/5427133991"


let APP_VERSION = "APP_Version"
let KP_USER_DEFAULT = UserDefaults.standard
let KPLUS_LANG_ENGLISH = "en"
let KPLUS_LANG_VIETNAMESE = "vi"
let CORNER_RADIUS = IS_IPAD ? 6.0 : 3.0
let languageEn = "en"
let languageVi = "vi"
let languageNone = "none"
let TAB_BAR_SELCTED_COLOR = UIColor.init(red: 231/255.0, green: 0/255.0, blue: 20.0/255.0, alpha: 1.0)
let TAB_BAR_HEIGHT = 49
let BLACK_COLOR = UIColor.init(red: 231/255.0, green: 0/255.0, blue: 20.0/255.0, alpha: 1.0)
let HOME_PAGE_SEPRATOR_COLOR = UIColor.init(red: 231/255.0, green: 0/255.0, blue: 20.0/255.0, alpha: 1.0)
let BANNER_CONTAINER_VIEW_BACKGROUND = UIColor.init(red: 47/255.0, green: 47/255.0, blue: 47/255.0, alpha: 1.0)
let isPhone = (UIDevice.current.userInterfaceIdiom == .phone)
let is_OK = "OK"

let timeUtilSecond = 1
let timeUtilSecondsInAMinute = 60 * timeUtilSecond
let timeUtilSecondsInAnHour = 60 * timeUtilSecondsInAMinute
let timeUtilSecondsInADay = 24 * timeUtilSecondsInAnHour
let timeUtilMinutesInAnHour = 60
let timeUtilMinutesInADay = 24 * timeUtilMinutesInAnHour
public var mandatoryFields : [String : Bool] = ["phoneNumber" : false , "password" : false ,"serialNumber" : false ]


// MARK: - Channel/Video Cell Size

let HEIGHT_FOR_VOD_GROUP_LANDSCAPE : CGFloat = IS_IPAD ? 224 : 160
let HEIGHT_FOR_VOD_GROUP_PORTRAIT : CGFloat = IS_IPAD ? 368 : 230.0
let HEIGHT_FOR_CHANNEL_GROUP : CGFloat = IS_IPAD ? 224 : 142.0

let CELL_SIZE_VOD_GROUP_LANDSCAPE : CGSize = IS_IPAD ? CGSize.init(width: 224.0, height: 126.0) : CGSize.init(width: 160.0, height: 90.0)
let CELL_SIZE_VOD_GROUP_PORTRAIT : CGSize = IS_IPAD ? CGSize.init(width: 180.0, height: 270.0) : CGSize.init(width: 104.0, height: 156.0)
let CELL_SIZE_CHANNEL_GROUP : CGSize = IS_IPAD ? CGSize.init(width: 127.0, height: 127.0) : CGSize.init(width: 76.0, height: 76.0)

let CELL_INTERSPACING_VOD: CGFloat = IS_IPAD ? 15 : 10
let CELL_SECTIONINSET: CGFloat = IS_IPAD ? 24 : 16

let epgTimeInterval : TimeInterval = 60 * 60 * 24
let ACTUAL_HOUR : TimeInterval = 3600.0
let TILE_HOUR_WIDTH : CGFloat = 320
let TILE_HEIGHT : CGFloat = 64

let KEYBOARD_NUMBER_CHARACTERSET = "01234567890"

let KP_LOGGEDIN_USER_INFO = "userInfo"
let KP_VALIDATE_TOKEN_USER_INFO = "validateTokenInfo"
let KP_RECENTLY_SEARCHED_ARRAY = "Recently_Searched_Array"
let KP_MAX_NUMBER_OF_RECENTLY_SEARCHED_SUGGESTIONS = 6


// All Notifications
enum KPNotificationName: String {
    case languageChangedNotification = "KPLanguageChangedNotification"
    case qualityFoundNotification = "KPQualityFoundNotification"
}

enum KPUserDefaultKey: String {
    case passcodeMaxAttempts = "PASSCODE_MAX_ATTEMPTS"
    case invalidPasscodeAttempts = "INVALID_PASSCODE_ATTEMPTS"
}
