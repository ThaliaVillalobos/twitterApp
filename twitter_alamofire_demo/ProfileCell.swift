//
//  ProfileCell.swift
//  twitter_alamofire_demo
//
//  Created by Thalia Villalobos on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var createdAT: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!

    var tweet: Tweet! {
        didSet {
            print("profile Cell")
            userTweet.text = tweet.text
            favoriteCount.text = (String(describing:tweet.favoriteCount!))
            
            userName.text = tweet.user.name
            screenName.text = "@\(tweet.user.screenName)"
            createdAT.text = tweet.createdAtString
            retweetCount.text = (String(tweet.retweetCount))
            userImage.af_setImage(withURL: tweet.user.profileImage!)
            
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
