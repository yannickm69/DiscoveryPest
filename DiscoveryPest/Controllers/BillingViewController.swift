//
//  BillingViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/1/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import Alamofire
import PDFKit

class BillingViewController: UIViewController {
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var payButton: UIButton!
    let prefs = UserDefaults.standard
    @IBOutlet weak var busy: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        getStatement()
        payButton.layer.borderWidth = 1.0
        payButton.layer.cornerRadius = 5

        busy.startAnimating()

    }

    func getStatement(){
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }

            Alamofire.request(ViewController.BASEURL + "customerStatement/\(user)", method: .get, headers: headers).response{
                response in

                if let data = response.data{
                    //convert to byte[] from base64 string
                    if let convertedData = Data(base64Encoded: data, options: .ignoreUnknownCharacters){
                        self.pdfView.document = PDFDocument(data: convertedData)
                        self.busy.stopAnimating()
                    }
                }

            }

        }

    }

    @IBAction func makePayment(_ sender: Any) {
        let ac = UIAlertController(title: "Enter Amount To Pay", message: "Note: You will not be able to make a payment if you have not registered a credit card with Discovery Pest.", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action : UIAlertAction) in
             print("cancel out")
            }))
        
        ac.addAction(UIAlertAction(title: "Call to Register", style: .default, handler: { (action : UIAlertAction) in
            UIApplication.shared.open(URL(string: "tel://9256342221")!)
        }))

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0].text

            // send to server
            if NetworkReachabilityManager()!.isReachable{
                //Authenticate with server
                let user = self.prefs.string(forKey: "account") ?? "empty"
                let password = self.prefs.string(forKey: "password") ?? "empty"

                let parameters = [
                    "mCustomerCode": user,
                    "mAmount": answer ?? ""
                ]

                var headers : HTTPHeaders = [:]
                if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                    headers[authorizationheader.key] = authorizationheader.value
                }

                Alamofire.request(ViewController.BASEURL + "submitPayment", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{
                    response in
                    if response.result.isSuccess{

                        do {
                            let jsonDecoder = JSONDecoder()
                            if let jsonData = response.data {
                                let receipt = try jsonDecoder.decode(AuthNetReceipt.self, from: jsonData)

                                let alertController = UIAlertController(title: "Payment", message:"Your payment was submitted. Authorization code : \(receipt.authCode)", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Close", style: .default))
                                self.present(alertController, animated: true, completion: nil)
                            }

                        }
                        catch let error{
                            print(error)
                        }
                    }
                }

            }
        }

        ac.addAction(submitAction)

        present(ac, animated: true)


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
