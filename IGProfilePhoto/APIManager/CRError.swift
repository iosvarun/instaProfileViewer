//
//  CRError.swift
//  CallRecoder
//
//  Created by Varun Kumar on 09/01/21.
//  Copyright © 2021 Varun Kumar. All rights reserved.
//

import Foundation

public enum CRError: Error {
    case error(Error)
    case description(String)
    case noInternet
    case noData
    case notAbleToParseData
    case descriptionWithTitle(String, String)

    var title: String {
        
        switch self {
        case .error:
            return API_FAILURE_TITLE
        case .description(let description):
            return description
        case .noInternet:
            return NO_INTERNET_ALERT_TITLE
        case .noData:
            return NO_DATA_TITLE
        case .notAbleToParseData:
            return PARSING_ERROR_TITLE
        case .descriptionWithTitle(let title, _):
            return title
        }
        
    }
    
    var description: String {
        
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .description(let description):
            return description
        case .noInternet:
            return NO_INTERNET_MESSAGE
        case .noData:
            return NO_DATA_PRESENT_MESSAGE
        case .notAbleToParseData:
            return PARSING_ERROR_MESSAGE
        case .descriptionWithTitle(_, let description):
            return description
        }
        
    }
    
    
}
