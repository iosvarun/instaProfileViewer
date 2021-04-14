//
//  InAppViewModel.swift
//  DirectMessage
//
//  Created by Varun Kumar on 07/04/21.
//

import Foundation

class InAppViewModel: NSObject {
    enum SettingKey:String {
        case RemoveAd = "Remove ads", RemoveBannerAd = "Remove the banner ad", CopyPaste = "Unlock the auto paste functionality", CustomMessage = "Unlock unlimited custom message", ShareLocation = "Unlock share current location."        
        var  urlString: String  {
            
            switch self {
            case .RemoveAd:
                return ""
            case .RemoveBannerAd:
                return ""
            case .CopyPaste:
                return ""
            case .CustomMessage:
                return ""
            case .ShareLocation:
                return ""
            }
        }
    }
}
