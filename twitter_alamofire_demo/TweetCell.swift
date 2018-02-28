//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoritedCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            favoritedCount.text = (String(describing:tweet.favoriteCount!))
      
            userName.text = tweet.user.name
            userScreenName.text = tweet.user.screenName
            createdAt.text = tweet.createdAtString
            retweetCount.text = (String(tweet.retweetCount))
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        tweet.favorited = true
        tweet.favoriteCount! += 1
        
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        tweet.retweeted = true
        tweet.retweetCount += 1
        
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweet: \n\(tweet.text)")
            }
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
