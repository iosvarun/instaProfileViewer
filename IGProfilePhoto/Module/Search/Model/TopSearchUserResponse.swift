//
//  TopSearchUserResponse.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 13/04/21.
//

import Foundation

struct TopSearchUserResponse: Codable {

    var user: [SearchUser]?
    private enum CodingKeys: String, CodingKey {
        case result
        case data
        case user = "users"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            user = try values.decode([SearchUser].self, forKey: .user)
        }catch {
            print("user error \(error.localizedDescription)")
        }
    }
    
    func encode(to encoder: Encoder) throws {
    }
}
