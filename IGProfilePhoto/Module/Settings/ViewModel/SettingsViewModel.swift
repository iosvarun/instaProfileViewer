//
//  SettingsViewModel.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import StoreKit

protocol ViewModelDelegate {
    func toggleOverlay(shouldShow: Bool)
    func willStartLongProcess()
    func didFinishLongProcess()
    func showIAPRelatedError(_ error: Error)
    func shouldUpdateUI()
    func didFinishRestoringPurchasesWithZeroProducts()
    func didFinishRestoringPurchasedProducts()
}

class SettingsViewModel: NSObject {
    
    enum SettingKey:String {
//        case RemoveAd = "Remove Ad", ContactUs = "Contact Us", RateApp = "Rate App", ShareApp = "Share This App",FAQ = "FAQ", PrivacyPolicy = "Privacy Policy", TermsAndCondition = "Terms And Condition"
        case ContactUs = "Contact Us", RateApp = "Rate App", ShareApp = "Share This App",FAQ = "FAQ", PrivacyPolicy = "Privacy Policy", TermsAndCondition = "Terms And Condition"

        
        var  urlString: String  {
            
            switch self {
//            case .RemoveAd:
//                return ""
            case .ContactUs:
                return ""
            case .RateApp:
                return ""
            case .ShareApp:
                return ""
            case .FAQ:
                return ""
            case .PrivacyPolicy:
                return ""
            case .TermsAndCondition:
                return ""
            }
        }
    }
}
