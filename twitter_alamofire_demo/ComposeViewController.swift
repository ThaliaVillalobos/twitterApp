//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Thalia Villalobos on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate : NSObjectProtocol {
    
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var newTweet: UITextView!
    
    weak var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationBar = self.navigationController?.navigationBar {

            let secondFrame = CGRect(x: navigationBar.frame.width/1.4, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            
            let secondLabel = UILabel(frame: secondFrame)
            secondLabel.textColor = UIColor.gray
            secondLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(14) )
            secondLabel.text = "140"
            
            navigationBar.addSubview(secondLabel)
        }
        // Do any additional setup after loading the view.
    }
    
    //TweetButton action
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: "hello") { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
