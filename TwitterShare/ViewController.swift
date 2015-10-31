//
//  ViewController.swift
//  TwitterShare
//
//  Created by Miguel Fagundez on 10/30/15.
//  Copyright © 2015 Miguel Fagundez. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTweetTextView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showShareAction(sender: UIBarButtonItem) {
        if self.tweetTextView.isFirstResponder(){
            self.tweetTextView.resignFirstResponder()
        }
        
        let alertCtrl = UIAlertController(title: "Tweet Share", message: "Tweet Your Note!", preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        let tweetAction = UIAlertAction(title: "Tweet", style: .Default, handler:{
        _ in
            
            // If user has signed on Twitter
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
                let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                if self.tweetTextView.text.characters.count < 140 {
                    twitterVC.setInitialText(self.tweetTextView.text)
                }else{
                    twitterVC.setInitialText(self.tweetTextView.text.substringToIndex(self.tweetTextView.text.startIndex.advancedBy(140)))
                }
                
                self.presentViewController(twitterVC, animated: true, completion: nil)
            }else{
                self.showAlertMessage("Please Sign In Twitter Before You Tweet!")
            }
            
            
        })
        
        alertCtrl.addAction(cancelAction)
        alertCtrl.addAction(tweetAction)
        
        self.presentViewController(alertCtrl, animated: true, completion: nil)
    }
    
    func configureTweetTextView(){
        self.tweetTextView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 0.9, alpha: 1).CGColor
        
        self.tweetTextView.layer.cornerRadius = 10.0
        self.tweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        self.tweetTextView.layer.borderWidth = 2.0
        
    }
    
    func showAlertMessage(message: String){
        let alertCtrl = UIAlertController(title: "Tweet Share", message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertCtrl.addAction(alertAction)
        self.presentViewController(alertCtrl, animated: true, completion: nil)
        
    }
}

