//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Thalia Villalobos on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTagLebel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let tweet = tweet{
          usernameLabel.text = tweet.user.name
          userTagLebel.text = "@\(tweet.user.screenName)"
          tweetLabel.text = tweet.text
          postTimeLabel.text = tweet.createdAtString
          favoriteCountLabel.text = (String(describing:tweet.favoriteCount!))
          retweetCountLabel.text = (String(tweet.retweetCount))
          userProfileImage.af_setImage(withURL: tweet.user.profileImage!)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
