//
//  DateExtension.swift
//  DirectMessage
//
//  Created by Varun Kumar on 08/04/21.
//

import Foundation

extension Date {
    public func isLessThan(_ subscriptionDate: Date) -> Bool {
        if self.timeIntervalSince(subscriptionDate) < subscriptionDate.timeIntervalSinceNow {
            return true
        } else {
            return false
        }
    }
}
