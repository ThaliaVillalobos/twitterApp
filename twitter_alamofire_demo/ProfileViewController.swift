//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Thalia Villalobos on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var bacgroundImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = User.current?.name
        userImage.af_setImage(withURL: (User.current?.profileImage!)!)
        userScreenName.text = User.current?.screenName
        bacgroundImage.af_setImage(withURL: (User.current?.banner_url)!)
        followingCount.text =  "\(User.current!.following!)"
        favoriteCount.text = "\(User.current!.tweets!)"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTapHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
