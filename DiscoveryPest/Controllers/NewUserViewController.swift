//
//  NewUserViewController.swift
//  DiscoveryPest
//
//  Created by user157258 on 7/4/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import WebKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let url = URL(string:"https://discoverypest.com/mobile/createuser.aspx")!
        webview.load(URLRequest(url:url))
        
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
