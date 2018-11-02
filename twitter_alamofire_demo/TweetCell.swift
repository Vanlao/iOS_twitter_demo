//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Tu Pham on 10/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    @IBOutlet weak var UserImg: UIImageView!
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var Textcontent: UILabel!
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBOutlet weak var Replybutton: UIButton!
    @IBOutlet weak var MessageButton: UIButton!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var RetweetButton: UIButton!
    var refresh = UIRefreshControl()
    var tweetVariable: Tweet!{
        didSet{
            UserImg.af_setImage(withURL: (tweetVariable.user?.profileImgURL)!)
            UserName.text = tweetVariable.user?.screenName!
            datePosted.text = tweetVariable.createdAtString
            Textcontent.text = tweetVariable.text
            retweetCount.text = "\((tweetVariable.retweetCount)!)"
            favoriteCount.text = "\((tweetVariable.favoriteCount)!)"
            replyCount.text = "\((tweetVariable.replyCount)!)"
            
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RetweetButton.setImage(UIImage(named:"retweet-icon"), for: .normal)
        FavoriteButton.setImage(UIImage(named:"favor-icon"), for: .normal)
        
        UserImg.layer.cornerRadius = 2  //autolayout
        UserImg.clipsToBounds = true    //autolayout
        UserName.preferredMaxLayoutWidth = UserName.frame.size.width    //autolayout
    }
    
    override func layoutSubviews() {
        super.layoutSubviews() //when the layout is changed
        
        UserName.preferredMaxLayoutWidth = UserName.frame.size.width //autolayout
    }

    @IBAction func didReply(_ sender: Any) {
    }
    @IBAction func didRetweet(_ sender: Any) {
        print("clicked")
        if tweetVariable.retweeted == false{
            tweetVariable.retweeted = true
            (tweetVariable.retweetCount)! += 1
            RetweetButton.setImage(UIImage(named:"retweet-icon-green"), for: .normal)
            performTweetAction(APIManager.TweetRequest.CallRetweet)
        }else{
            tweetVariable.retweeted = false
            (tweetVariable.retweetCount)! -= 1
            RetweetButton.setImage(UIImage(named:"retweet-icon"), for: .normal)
            performTweetAction(APIManager.TweetRequest.CallUnretweet)
        }
        retweetCount.text = "\((tweetVariable.retweetCount)!)" // update retweet count.
        
    }
    @IBAction func didFavorite(_ sender: Any) {
        print("clicked")
        if tweetVariable.favorited == false{
            tweetVariable.favorited = true
            (tweetVariable.favoriteCount)! += 1
            FavoriteButton.setImage(UIImage(named:"favor-icon-red"), for: .normal)
            performTweetAction(APIManager.TweetRequest.CallFavorite)
        }else{
            tweetVariable.favorited = false
            (tweetVariable.favoriteCount)! -= 1
            FavoriteButton.setImage(UIImage(named:"favor-icon"), for: .normal)
            performTweetAction(APIManager.TweetRequest.CallUnfavorite)
        }
        favoriteCount.text = "\((tweetVariable.favoriteCount)!)" //update favorite count.
    }
    
    //calling the request method in APIManager.
    //all credits to Jacob Frick for this code.
    func performTweetAction(_ action: APIManager.TweetRequest) {
        APIManager.shared.performTweetAction(tweetVariable!, action) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error perform action: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully performed action.")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}
