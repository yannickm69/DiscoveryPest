//
//  WebViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/2/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var url = ""
    let webview = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        if url != "" {
            webview.load(url)
        }

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = webview
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


extension WKWebView{
    func load(_ urlString : String){
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
