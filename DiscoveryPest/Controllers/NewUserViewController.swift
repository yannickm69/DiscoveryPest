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
    

}
