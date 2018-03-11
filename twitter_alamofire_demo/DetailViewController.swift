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
        
          if(tweet.favorited)!{
              favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
          }
          else{
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
          }
          if(tweet.retweeted){
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
          }
          else{
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
          }
        
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapRetweet(_ sender: AnyObject) {
        if(tweet.retweeted == false){
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetCountLabel.text = "\(tweet.retweetCount)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            APIManager.shared.retweet(tweet, completion: { (tweet, error) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeting the following Tweet: \n\(tweet.text)")
                }
            })
        }
        else{
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetCountLabel.text = "\(tweet.retweetCount)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            APIManager.shared.unretweet(tweet, completion: { (tweet, error) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            })
        }
    }

    @IBAction func didTapFavorite(_ sender: AnyObject) {
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount! += 1
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            })
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            print("About to reply")
            let replyViewController = segue.destination as! ReplyViewController
            replyViewController.tweet = tweet
        }
    }
 

}
