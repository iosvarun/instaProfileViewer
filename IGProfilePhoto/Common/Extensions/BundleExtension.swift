//
//  BundleExtension.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import UIKit

extension Bundle {
    // Name of the app - title under the icon.
    var displayName: String? {
            return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
