//
//  ViewController.swift
//  DiscoveryPest
//
//  Created by user157258 on 6/28/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    let prefs = UserDefaults.standard
    public static let BASEURL = "https://service.athenafirst.com/PublicWeb.svc/"
    
    @IBOutlet weak var accountN: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func submit(_ sender: UIButton) {
        //TODO save account and pass
        
        prefs.set(accountN.text, forKey: "account")
        prefs.set(password.text, forKey: "password")
        
        performSegue(withIdentifier: "toHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               
        //dismiss keyboard on touch
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self.view, action:#selector(UIView.endEditing(_:))))
        
        //fill inputs with saved defaults
        accountN.text = prefs.string(forKey: "account")
        password.text = prefs.string(forKey: "password")
        
        //auto login
        _ = isUser()
        
    }

    
    //MARK Networking
    func isUser () -> Bool{
        let result : Bool = false
        
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }
            
            Alamofire.request(ViewController.BASEURL + "isUser", headers: headers).responseJSON{
                response in
                if let json = response.result.value as? Int  {
                    if json == 1 {
                        self.performSegue(withIdentifier: "toHome", sender: self)
                    }
                }
            }
            
        }
        return result
    }
}

