//
//  HomeViewController.swift
//  DiscoveryPest
//
//  Created by user157258 on 7/4/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var vcToLoad:String = "";
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var drawer: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var drawerOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawer.layer.borderWidth = 1
        drawer.layer.borderColor = UIColor.lightGray.cgColor
        if vcToLoad != ""{
            switch (vcToLoad) {
            case "mySvc":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: vcToLoad) as! MyServicesViewController
                viewContainer.addSubview(vc.view)
            default:
                break
            }
            
        }
    }
    
    @IBAction func closeDrawer(_ sender: UISwipeGestureRecognizer) {
        manageDrawer()
    }
    
    fileprivate func manageDrawer() {
        if drawerOpen {
            leadingConstraint.constant = -250
            //hide overlay
            overlay.isHidden = true
            
        }else{
            leadingConstraint.constant = 0
            //show overlay
            overlay.isHidden = false
            //self.navigationController?.isNavigationBarHidden = true
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
        drawerOpen = !drawerOpen
    }
    
    @IBAction func openDrawer(_ sender: UIBarButtonItem) {
        
        manageDrawer()
    }
    
    @IBAction func drawerPress(_ sender: UIButton) {
        //TODO manage menu selections
        if let title = sender.titleLabel{
            switch title.text{
            case "Twitter":
                let screenName =  "DiscoveryPest"
                let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
                let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
                
                let application = UIApplication.shared
                
                if application.canOpenURL(appURL as URL) {
                    application.open(appURL as URL)
                } else {
                    application.open(webURL as URL)
                }
                
            case "Facebook":
                let webURL = NSURL(string: "https://www.facebook.com/Discovery-Pest-Control-127639957314232/")!
                let application = UIApplication.shared
                application.open(webURL as URL)
                
            default:
                debugPrint(title.text ?? " ")
            }
            
        }
        
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
