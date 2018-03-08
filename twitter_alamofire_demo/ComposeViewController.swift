//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Thalia Villalobos on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
//import AlamofireImage

protocol ComposeViewControllerDelegate : NSObjectProtocol {
    
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var newTweet: UITextView!
    
    weak var delegate: ComposeViewControllerDelegate?
    var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTweet.delegate = self
        newTweet.isEditable = true
        
        userNameLabel.text = User.current?.name
        userScreenNameLabel.text = "@\(String(describing: User.current!.screenName))"
        userImage.af_setImage(withURL: (User.current?.profileImage!)!)
        
        if let navigationBar = self.navigationController?.navigationBar {
            let secondFrame = CGRect(x: navigationBar.frame.width/1.4, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
    
            secondLabel = UILabel(frame: secondFrame)
            secondLabel.textColor = UIColor.gray
            secondLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(14) )
            secondLabel.text = "140"
            
            navigationBar.addSubview(secondLabel)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    //TweetButton action
    @IBAction func didTapPost(_ sender: Any) {
        print("about to post tweet")
        APIManager.shared.composeTweet(with: newTweet.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        secondLabel.text = String(characterLimit - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
