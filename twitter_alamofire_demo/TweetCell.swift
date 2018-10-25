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
    }

    @IBAction func didReply(_ sender: Any) {
    }
    @IBAction func didRetweet(_ sender: Any) {
        print("clicked")
        tweetVariable.retweeted = true
        (tweetVariable.retweetCount)! += 1
        let uiImage = UIImage(named: "retweet-icon-green")
        RetweetButton.imageView?.image = uiImage
        
    }
    @IBAction func didFavorite(_ sender: Any) {
        print("clicked")
        tweetVariable.favorited = true
        (tweetVariable.favoriteCount)! += 1
        let uiImage = UIImage(named: "favor-icon-red")
        FavoriteButton.imageView?.image = uiImage
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
