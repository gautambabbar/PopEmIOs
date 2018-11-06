//
//  MainViewController.swift
//  Balloons
//
//  Created by Gautam Babbar on 9/12/18.
//  Copyright © 2018 Sarthak Babbar. All rights reserved.
//

import UIKit
import GoogleMobileAds


class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var highScoreLabel: UILabel!

    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var drpDownSettings: UIPickerView!
    
   
    var pickerData: [String] = [String]()  // create Settings list
    
    var bannerView: GADBannerView!

    var selectedSetting: String?
    
    
    override func viewDidLoad() {
        
        
        
        
        super.viewDidLoad()
        
        
        
        
        // Connect data:
        self.drpDownSettings.delegate = self
        self.drpDownSettings.dataSource = self
        
        // Input the data into the array
        pickerData = ["","Instructions"]
        
     
        // this is the code to upate the highscore
        let highScore = UserDefaults.standard.string(forKey: "highScore") ?? "0"
        highScoreLabel.text = "High Score: " + highScore
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background.png")?.draw(in: self.view.bounds)
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
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberofComponentsInPickerView(pickerView:UIPickerView) -> Int {
        return 1
    
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        switch pickerData[row]{
        case "Instructions":
            performSegue(withIdentifier: "goToInstructionsFromMain", sender: self) // This code works!! for programatic exit
            
        case "SignUp":
        performSegue(withIdentifier: "goToSignUpFromMain", sender: self)
        default:
            drpDownSettings.isHidden = false
           
        }
        
        drpDownSettings.isHidden = true
        
        
        
    }
    
    
    
    @IBAction func btnSettingsClick(_ sender: Any) {
        
       drpDownSettings.isHidden = false
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
