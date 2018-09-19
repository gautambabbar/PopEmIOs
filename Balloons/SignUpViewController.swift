//
//  SignUpViewController.swift
//  Balloons
//
//  Created by Gautam Babbar on 9/19/18.
//  Copyright © 2018 Sarthak Babbar. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Loading rewarded  ad here..
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-3940256099942544/1712485313") // Test Ad
        
        //GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),withAdUnitID: "ca-app-pub-9895741583663083/7067689930") //Real Ad
        
        
    }
    
    
    @IBAction func btnOK(_ sender: Any) {
        
       // Display pre loaded rewarded ad
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        
        
        
        performSegue(withIdentifier: "goToMainFromSignUp", sender: self) // This code works!! for programatic exit
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
