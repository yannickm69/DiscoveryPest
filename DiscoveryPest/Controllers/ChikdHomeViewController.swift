//
//  ChikdHomeViewController.swift
//  DiscoveryPest
//
//  Created by user157258 on 7/11/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import Alamofire

class ChikdHomeViewController: UIViewController {

    @IBOutlet weak var svcBtn: UIButton!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var lastServiceType: UILabel!
    @IBOutlet weak var serviceAddress: UILabel!
    @IBOutlet weak var lastService: UILabel!
    @IBOutlet weak var nextService: UILabel!
    
    @IBOutlet weak var billing: UIView!
    @IBOutlet weak var myServices: UIView!
    
    let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(manageTouch))
        myServices.addGestureRecognizer(gesture)
        
        //TODO set label from API call
        customerName.text = "NORMA"
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }
            
            Alamofire.request(ViewController.BASEURL + "getCurrentService/\(user)", method: .post, headers: headers).response{
                response in
                do {
                    let jsonDecoder = JSONDecoder()
                    if let jsonData = response.data {
                        let currentService = try jsonDecoder.decode(CurrentService.self, from: jsonData)
                        self.customerName.text = "\(currentService.mCustomerName) - \(currentService.mCustomerAccount)"
                        //calculate reminder
                        let days = Int(currentService.mReminder)!
                        var reminder : String
                            if(days > 7 || days < 0){
                            reminder = "  No scheduled service within 7 days."
                        }else{
                            reminder = "  REMINDER: \(currentService.mReminder) days until service."
                        }
                        // get today
                        let today = Date()
                        let dateformatter = DateFormatter()
                        dateformatter.dateFormat = "MM/dd/yyyy"
                        if let sdate = dateformatter.date(from: currentService.mServiceDate){
                            if(today > sdate){
                                self.serviceTypeLabel.text = "Last Service Type"
                                self.nextService.text = currentService.mFrequency
                            }else{
                                self.serviceTypeLabel.text = "Upcoming Service Type"
                                self.nextService.text = currentService.mServiceDate
                            }
                            
                            
                        }
                        
                        
                        self.warning.text = reminder
                        self.lastServiceType.text = "\(currentService.mServiceType) \n \(currentService.mServiceSubType)"
                        self.serviceAddress.text = currentService.mServiceAddress
                        self.lastService.text = currentService.mLastServiceDate
                    }
                    
                }
                catch{
                    print("Error fetching data")
                }
                
            }
            
        }
        
    }
    
    @objc func manageTouch(_ sender: UITapGestureRecognizer) {
        print("button clicked")
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