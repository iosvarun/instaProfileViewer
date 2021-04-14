//
//  SearchUser.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 13/04/21.
//

import Foundation




struct User: Codable {
    var pk: String?
    var username: String?
    var full_name: String?
    var is_private: Bool?
    var profile_pic_url: String?
    var profile_pic_id: String?
    var is_verified: Bool?
    
    var has_anonymous_profile_picture: Bool?
    var mutual_followers_count: Int?
    var account_badges: [String]?
    var latestReelMedia: Int?
    
    private enum CodingKeys: String, CodingKey {
        case pk
        case username
        case full_name
        case is_private
        case profile_pic_url
        case profile_pic_id
        case is_verified
        case has_anonymous_profile_picture
        case mutual_followers_count
        case account_badges
        case latestReelMedia = "latest_reel_media"
                
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            pk = try values.decode(String.self, forKey: .pk)
        }catch {
            print("pk error \(error.localizedDescription)")
        }
        
        do{
            username = try values.decode(String.self, forKey: .username)
        }catch {
            print("username error \(error.localizedDescription)")
        }
        
        do{
            full_name = try values.decode(String.self, forKey: .full_name)
        }catch {
            print("full_name error \(error.localizedDescription)")
        }
        
        do{
            is_private = try values.decode(Bool.self, forKey: .is_private)
        }catch {
            print("is_private error \(error.localizedDescription)")
        }
        
        do{
            profile_pic_url = try values.decode(String.self, forKey: .profile_pic_url)
        }catch {
            print("profile_pic_url error \(error.localizedDescription)")
        }
        
        do{
            profile_pic_id = try values.decode(String.self, forKey: .profile_pic_id)
        }catch {
            print("userID error \(error.localizedDescription)")
        }
        
        do{
            is_verified = try values.decode(Bool.self, forKey: .is_verified)
        }catch {
            print("is_verified error \(error.localizedDescription)")
        }
        
        do{
            has_anonymous_profile_picture = try values.decode(Bool.self, forKey: .has_anonymous_profile_picture)
        }catch {
            print("has_anonymous_profile_picture error \(error.localizedDescription)")
        }
        
        do{
            mutual_followers_count = try values.decode(Int.self, forKey: .mutual_followers_count)
        }catch {
            print("mutual_followers_count error \(error.localizedDescription)")
        }
        
        do{
            account_badges = try values.decode(Array.self, forKey: .account_badges)
        }catch {
            print("account_badges error \(error.localizedDescription)")
        }
        
        do{
            latestReelMedia = try values.decode(Int.self, forKey: .latestReelMedia)
        }catch {
            print("latestReelMedia error \(error.localizedDescription)")
        }
        
       
    }

}


struct SearchUser: Codable {
    
    var position: Int?
    var user: User?

    private enum CodingKeys: String, CodingKey {
        case position
        case user = "users"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            position = try values.decode(Int.self, forKey: .position)
        }catch {
            print("position error \(error.localizedDescription)")
        }
        
        do{
            user = try values.decode(User.self, forKey: .user)
        }catch {
            print("user error \(error.localizedDescription)")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}
