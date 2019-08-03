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
            case "bvc":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: vcToLoad) as! BillingViewController
                addChildView(childView: vc)
            case "avc":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: vcToLoad) as! AccountInfoVC
                addChildView(childView: vc)
            case "schedvc":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: vcToLoad) as! SchedViewController
                addChildView(childView: vc)
            default:
                break
            }
            
        }

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeOpenDrawer))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }

    @objc func swipeOpenDrawer(){
        if !drawerOpen{manageDrawer()}
    }

    //add vc
    func addChildView(childView : UIViewController){
        addChild(childView)
        viewContainer.addSubview(childView.view)
        childView.view.frame = viewContainer.frame
        childView.didMove(toParent: self)
    }

    //MARK: - Drawer nav
    @IBAction func closeDrawer(_ sender: UISwipeGestureRecognizer) {
        if drawerOpen{ manageDrawer()}
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
            case "Home":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "cvc") as! ChikdHomeViewController
                addChildView(childView: vc)

            case "Our Services":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as! WebViewController
                vc.url = "https://discoverypest.com/mobile/app_services.aspx"
                addChildView(childView: vc)

            case "Helpful Tips":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as! WebViewController
                vc.url = "https://discoverypest.com/mobile/app_tips.aspx"
                addChildView(childView: vc)

            case "About Us":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as! WebViewController
                vc.url = "https://discoverypest.com/mobile/app_about_us.aspx"
                addChildView(childView: vc)
            default:
                debugPrint(title.text ?? " ")
            }
            manageDrawer()
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
