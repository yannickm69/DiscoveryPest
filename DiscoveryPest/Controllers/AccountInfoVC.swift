//
//  AccountInfoVC.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/2/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import Alamofire

class AccountInfoVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var phoneH: UITextField!
    @IBOutlet weak var phoneW: UITextField!
    @IBOutlet weak var invoiceMemo: UITextView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var bFullname: UITextField!
    @IBOutlet weak var bAddress1: UITextField!
    @IBOutlet weak var bAddress2: UITextField!
    @IBOutlet weak var bCity: UITextField!
    @IBOutlet weak var bState: UITextField!
    @IBOutlet weak var bZip: UITextField!
    @IBOutlet weak var bPhoneH: UITextField!
    @IBOutlet weak var bPhoneW: UITextField!
    @IBOutlet weak var bEmail: UITextField!
    @IBOutlet weak var byMail: UISwitch!
    @IBOutlet weak var byEmail: UISwitch!
    @IBOutlet weak var bByMail: UISwitch!
    @IBOutlet weak var bByEmail: UISwitch!
    @IBOutlet weak var cCard: UILabel!
    @IBOutlet weak var sendStatement: UISwitch!
    @IBOutlet weak var submit: UIButton!

    let prefs = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        fullName.delegate = self
        address1.delegate = self
        address2.delegate = self
        city.delegate = self
        state.delegate = self
        zip.delegate = self
        phoneH.delegate = self
        phoneW.delegate = self
        email.delegate = self
        invoiceMemo.delegate = self
        bFullname.delegate = self
        bAddress1.delegate = self
        bAddress2.delegate = self
        bCity.delegate = self
        bState.delegate = self
        bZip.delegate = self
        bPhoneH.delegate = self
        bPhoneW.delegate = self
        bEmail.delegate = self

        //round button
        submit.layer.cornerRadius = 5
        submit.addTarget(self, action: #selector(sendData(sender:)), for: .touchUpInside)
        

        getData()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }

    // MARK: - Get Data
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
                        let currentService = try jsonDecoder.decode(CustomerInfo.self, from: jsonData)
                        self.fullName.text = currentService.mFullName
                        self.address1.text = currentService.mPropertyAddress1
                        self.address2.text = currentService.mPropertyAddress2
                        self.city.text = currentService.mPropertyCity
                        self.state.text = currentService.mPropertyState
                        self.zip.text = currentService.mPropertyZip
                        self.phoneW.text = currentService.mPropertyPhoneWork
                        self.phoneH.text = currentService.mPropertyPhoneHome
                        self.email.text = currentService.mPropertyEmail
                        self.invoiceMemo.text = currentService.mInvoiceMemo
                        self.byMail.isOn = currentService.mNotifyPropertyMail
                        self.bFullname.text = "\(currentService.mBillingName) \(currentService.mBillingLastName)"
                        self.bAddress1.text = currentService.mBillingAddress1
                        self.bAddress2.text = currentService.mBillingAddress2
                        self.bCity.text = currentService.mBillingCity
                        self.bState.text = currentService.mBillingState
                        self.bZip.text = currentService.mBillingZip
                        self.bPhoneW.text = currentService.mBillingPhoneWork
                        self.bPhoneH.text = currentService.mBillingPhoneHome
                        self.bEmail.text = currentService.mBillingEmail
                        self.bByMail.isOn = currentService.mNotifyBillingMail
                        self.bByEmail.isOn = currentService.mNotifyBillingEmail
                        self.cCard.text = "\(currentService.mPaymentMethod) \(currentService.mCCCode) (Call 925-634-2221 to change your credit card on file.)"
                        self.sendStatement.isOn = currentService.mEmailStatements.contains("True") ? true : false
                    }

                }
                catch{
                    print("Error fetching data")
                }

            }

        }
    }

    // MARK - Send Data to Server
    @objc func sendData(sender : UIButton){
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = self.prefs.string(forKey: "account") ?? "empty"
            let password = self.prefs.string(forKey: "password") ?? "empty"

            let fullNameArr = self.fullName.text?.components(separatedBy: " ")
            let firstName = fullNameArr?[0] ?? ""
            let lastName = fullNameArr?.count ?? 0 > 1 ? fullNameArr?[1] : nil

            let bFullNameArr = self.fullName.text?.components(separatedBy: " ")
            let bFirstName = bFullNameArr?[0] ?? ""
            let bLastName = bFullNameArr?.count ?? 0 > 1 ? bFullNameArr?[1] : nil


                    let parameters : [String : Any] = [
                    "mCustomerCode" : user,
                    "mPropertyName" : firstName,
                    "mPropertyLastName" : lastName ?? "",
                    "mPropertyAddress1" : self.address1.text ?? "",
                    "mPropertyAddress2" : self.address2.text ?? "",
                    "mPropertyCity" : self.city.text ?? "",
                    "mPropertyState" : self.state.text ?? "",
                    "mPropertyZip" : self.zip.text ?? "",
                    "mPropertyPhoneWork" : self.phoneW.text ?? "",
                    "mPropertyPhoneHome" : self.phoneH.text ?? "",
                    "mPropertyEmail" : self.email.text ?? "",
                    "mInvoiceMemo" : self.invoiceMemo.text ?? "",
                    "mBillingName" : bFirstName,
                    "mBillingLastName" : bLastName ?? "",
                    "mBillingAddress1" : self.bAddress1.text ?? "",
                    "mBillingAddress2" : self.bAddress2.text ?? "",
                    "mBillingCity" : self.bCity.text ?? "",
                    "mBillingState" : self.bState.text ?? "",
                    "mBillingZip" : self.bZip.text ?? "",
                    "mBillingPhoneWork" : self.bPhoneW.text ?? "",
                    "mBillingPhoneHome" : self.bPhoneH.text ?? "",
                    "mBillingEmail" : self.bEmail.text ?? "",
                    "mNotifyPropertyMail" : self.byMail?.isOn ?? false,
                    "mNotifyPropertyEmail" : self.byEmail?.isOn ?? false,
                    "mNotifyBillingEmail" : self.bByEmail?.isOn ?? false,
                    "mNotifyBillingMail" : self.bByMail?.isOn ?? false,
                    "mEmailStatements" : self.sendStatement.isOn ? "True" : "False"
                ]


                var headers : HTTPHeaders = [:]
                if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                    headers[authorizationheader.key] = authorizationheader.value
                }

            Alamofire.request("\(ViewController.BASEURL)updateCustomer", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString{
                    response in
                    print(response)

                      if response.result.isSuccess{
                     let alertController = UIAlertController(title: "Profile Info", message:
                     "Your request to update your information was submitted.", preferredStyle: .alert)
                     alertController.addAction(UIAlertAction(title: "Close", style: .default))

                     self.present(alertController, animated: true, completion: nil)
                     }

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
