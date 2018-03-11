//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Thalia  on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var replyText: UITextView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyText.delegate = self
        replyText.isEditable = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapReply(_ sender: Any) {
        var replyTweet: [String: Any] = [:]
        
        replyTweet["text"] = self.replyText.text! + "@" + tweet.user.screenName
        replyTweet["id"] = tweet.id
        print(tweet.id)
        
        
        APIManager.shared.reply(with: replyTweet) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Reply Tweet Success!")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        characterCountLabel.text = String(characterLimit - newText.characters.count)
        
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }

}
