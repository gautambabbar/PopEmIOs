//
//  ViewController.swift
//  Balloons
//
//  Created by Sarthak Babbar on 9/8/18.
//  Copyright © 2018 Sarthak Babbar. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class ViewController:UIViewController{
    
    var scene: AnimationScene!
    var size: CGSize!
    var bannerView: GADBannerView!
    
    @IBAction func onProgClick(_ sender: Any) {
        performSegue(withIdentifier: "goToMain", sender: self) // This code works!! for programatic exit
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        size = self.view.frame.size
        scene = AnimationScene(size:size)
        
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Test Ad
        bannerView.adUnitID = "ca-app-pub-9895741583663083/3658375650" //RealAd
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        
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
    
    
}



