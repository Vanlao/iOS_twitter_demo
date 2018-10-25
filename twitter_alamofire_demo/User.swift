//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Tu Pham on 10/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation
class User{
    var name: String?
    var screenName: String?
    var profileImgURL: URL?
    static var current: User?

    init(dictionary: [String : Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        if let profileImgURLPathString: String = dictionary["profile_image_url_https"] as? String {
            profileImgURL = URL(string: profileImgURLPathString)!
        }
        
 
    }
}
