//
//  DeviceUtils.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import UIKit

struct DeviceUtils {
    
    static var currentDeviceModel: String {
        return UIDevice.current.model
    }
    
    static var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func setDeviceTypeID(_ deviceTypeID: String){
        UserDefaultsUtil.setString(deviceTypeID, key: UserDefaultsUtil.ReservedKey.deviceTypeID)
    }
    
    static func getDeviceTypeID() -> String? {
        let deviceTypeID = UserDefaultsUtil.getString(UserDefaultsUtil.ReservedKey.deviceTypeID)
        return deviceTypeID
    }

 
}
