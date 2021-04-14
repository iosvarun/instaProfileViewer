//
//  APIConstants.swift
//  CallRecoder
//
//  Created by Varun Kumar on 01/10/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]


public struct APIConstants {

    //Base URL
    static let baseURL = Config.baseURL

    static let registerSystemAPI  = "web/search/topsearch/?query="
    static let topsearchAPI  = "web/search/topsearch/?query="
    static let userChannel  = "/channel/?__a=1"
    //https://www.instagram.com/web/search/topsearch/?query=varun&count=10
    //https://www.instagram.com/pareek_pe_pareek/channel/?__a=1

}

let PARSING_ERROR_TITLE = "Parcing Error."
let NO_DATA_TITLE = "No Data."
let API_FAILURE_TITLE = "Api Failed."
let API_ERROR_TITLE = "Error"
let API_ERROR_MESSAGE = "Please Try Again Later"
let PARSING_ERROR_MESSAGE = "Not able to parse data"
let NO_DATA_PRESENT_MESSAGE = "No Data Present"
