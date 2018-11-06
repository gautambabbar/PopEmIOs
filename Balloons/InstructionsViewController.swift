//
//  InstructionsViewController.swift
//  Balloons
//
//  Created by Sarthak Babbar on 10/13/18.
//  Copyright © 2018 Sarthak Babbar. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InstructionsViewController: UIViewController {
    
    
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "instruction.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        // Do any additional setup after loading the view.
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        addBannerViewToView(bannerView)
        
        
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Test Ad
        bannerView.adUnitID = "ca-app-pub-9895741583663083/3658375650" //RealAd
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),withAdUnitID: "ca-app-pub-9895741583663083/7067689930") //Real Ad
        
        
        
    }
    
    
    
    
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    
    
    
    
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        // Display pre loaded rewarded ad
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        performSegue(withIdentifier: "goToMainFromInstructions", sender: self) // This code works!! for programatic exit
        
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
