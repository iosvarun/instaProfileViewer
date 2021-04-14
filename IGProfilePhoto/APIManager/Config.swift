//
//  Config.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

class Config{
    
    enum Environment: String {
        case dev, stage, prod
    }
    
    static let environment: Environment = .dev
    
    static var baseURL:String{
        switch environment {
        case .dev:
            return "https://www.instagram.com/"
        case .stage:
            return "https://www.instagram.com/"
        case .prod:
            return "https://www.instagram.com/"
        }
    }
    
}
