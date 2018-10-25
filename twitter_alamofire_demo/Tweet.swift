//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Tu Pham on 10/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation
class Tweet{
    var id: Int64? // For favoriting, retweeting & replying
    var text: String? // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int? // Update retweet count label
    var retweeted: Bool? // Configure retweet button
    var user: User? // Author of the Tweet
    var createdAtString: String? // String representation of date posted
    var replyCount: Int? // update reply count label
    var replied: Bool? //configure reply button
    var profImg: URL?
    
    // For Retweets
    var retweetedByUser: User?  // user who retweeted if tweet is retweet
    
    init(dictionary: [String: Any]){
        var dictionary = dictionary
        if let originalTweet = dictionary["retweeted_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            // Change tweet to original tweet
            dictionary = originalTweet
        }
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as! Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as? Bool
        replyCount = dictionary["reply_count"] as? Int ?? 0
        replied = dictionary["replied"] as? Bool
        // initialize user
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        // Format createdAt date string
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"//"E, MMM d yyyy HH:mm:ss Z" Ex: Sat, SEP 4 2018 05:32:05 +0000
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String and set the createdAtString property
        createdAtString = formatter.string(from: date)
    }
    //this function will reload all the tweets and return them.
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
