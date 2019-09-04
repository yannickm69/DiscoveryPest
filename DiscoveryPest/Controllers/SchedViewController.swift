//
//  SchedViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/2/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire

class SchedViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource,UITextFieldDelegate {
    @IBOutlet weak var reason: UITextField!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var morning: UIButton!
    @IBOutlet weak var afternoon: UIButton!
    @IBOutlet weak var submit: UIButton!
    var selected : UIButton!
    let prefs = UserDefaults.standard
    var customerInfo = CustomerInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        reason.delegate = self

        calendar.select(Date(), scrollToDate: true)
        selected = morning

        submit.layer.cornerRadius = 5
        submit.addTarget(self, action: #selector(sendRequest(sender:)), for: .touchUpInside)

        morning.layer.cornerRadius = 5
        afternoon.layer.cornerRadius = 5
        morning.addTarget(self, action: #selector(selectTime(sender:)), for: .touchUpInside)
        afternoon.addTarget(self, action: #selector(selectTime(sender:)), for: .touchUpInside)
        getData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    @objc func selectTime (sender : UIButton){
        let colourOn : UIColor = .init(red: 1/255, green: 113/255, blue: 168/255, alpha: 1)
        let colourOff : UIColor = .init(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)

        if let title = sender.titleLabel?.text!{
            if(title.contains("8:00am")){
                //morning selected
                selected = morning
                morning.backgroundColor = colourOn
                afternoon.backgroundColor = colourOff

            }else{
                //afternoon
                selected = afternoon
                afternoon.backgroundColor = colourOn
                morning.backgroundColor = colourOff
            }
        }


    }

    func getData(){


        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }

            Alamofire.request(ViewController.BASEURL + "customerInfo/\(user)", method: .post, headers: headers).response{
                response in
                do {
                    let jsonDecoder = JSONDecoder()
                    if let jsonData = response.data {
                        self.customerInfo = try jsonDecoder.decode(CustomerInfo.self, from: jsonData)
                    }
                }
                catch{
                    print("Error fetching data")
                }

            }

        }
    }

    @objc func sendRequest(sender : UIButton){
        print("sending \(selected.titleLabel!.text!) \(calendar.selectedDate!)")
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = self.prefs.string(forKey: "account") ?? "empty"
            let password = self.prefs.string(forKey: "password") ?? "empty"

            let printFormatter = DateFormatter()
            printFormatter.dateFormat = "MM/dd/yyyy"
            

            let parameters : [String : Any] = [
                "mCustomerCode" : user,
                "mPropertyName" : customerInfo.mPropertyName,
                "mPropertyLastName" : customerInfo.mPropertyLastName,
                "mPropertyAddress1" : customerInfo.mPropertyAddress1,
                "mPropertyAddress2" : customerInfo.mPropertyAddress2,
                "mPropertyCity" : customerInfo.mPropertyCity,
                "mPropertyState" : customerInfo.mPropertyState,
                "mPropertyZip" : customerInfo.mPropertyZip,
                "mPropertyPhoneWork" : customerInfo.mPropertyPhoneWork,
                "mPropertyPhoneHome" : customerInfo.mPropertyPhoneHome,
                "mScheduleDate" : printFormatter.string(from: calendar.selectedDate ?? Date()),
                "mTimeFrame" : selected.titleLabel!.text!,
                "mComment" : reason.text!
            ]

            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }

            Alamofire.request("https://discoverypest.com/api/schedule", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{
                response in
                let message =  response.result.isSuccess ? "Your schedule request was submitted." : "Error submitting schedule request, please try again later or call us at (925)634-2221"
                let alertController = UIAlertController(title: "Schedule Request", message:
                    message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Close", style: .default))

                self.present(alertController, animated: true, completion: nil)

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
