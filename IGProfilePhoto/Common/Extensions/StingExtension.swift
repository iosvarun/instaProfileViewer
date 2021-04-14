//
//  StingExtension.swift
//  DirectMessage
//
//  Created by Varun Kumar on 14/01/21.
//

import Foundation

extension String {
    func removeWhitespace() -> String {
        return self.replace(" ", with: "")
    }
    func replace(_ string: String, with withString: String) -> String {
        return replacingOccurrences(of: string, with: withString)
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
