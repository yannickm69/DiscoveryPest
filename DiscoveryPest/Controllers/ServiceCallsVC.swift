//
//  ServiceCallsVC.swift
//  DiscoveryPest
//
//  Created by user157258 on 7/25/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class ServiceCallsVC: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {




    @IBOutlet weak var serviceCallsTV: UITableView!

    var serviceCalls = [ServiceCall]()
    let prefs = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        serviceCallsTV.delegate = self
        serviceCallsTV.dataSource = self
        serviceCallsTV.register(UINib(nibName: "ServiceCallTVC", bundle: nil), forCellReuseIdentifier: "serviceCallCell")
        serviceCallsTV.rowHeight = 488.0
        serviceCallsTV.allowsSelection = false

        //load data
        getServiceCalls()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SERVICE CALLS")
    }

    //MARK: - tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCallCell", for: indexPath) as! ServiceCallTVC
        let sc = serviceCalls[indexPath.row]
        cell.title.text = "Invoice # \(sc.mInvoiceNumber)"
        cell.invoiceNumber.text = sc.mInvoiceNumber
        cell.techRef.text = sc.mTechRef

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "MM/dd/yyyy"
        if let sdate = dateformatter.date(from: sc.mServiceDate){
            cell.serviceDate.text = printFormatter.string(from: sdate)
        }else{
            cell.serviceDate.text = sc.mServiceDate
        }

        cell.invoiceType.text = sc.mInvoiceType
        cell.reason.text = sc.mTroubleCallReason
        cell.amount.text = sc.mServiceAmount.description
        cell.sprayLocation.text = sc.mSprayedLocation
        cell.serviceStatus.text = sc.mComp

        cell.sendNote.addTarget(self, action: #selector(sendNoteClick), for: .touchUpInside)
        cell.sendNote.tag = indexPath.row
        cell.sendNote.isHidden = sc.mComp.contains("Coming Up") ? false:true
        return cell
    }

    //send note button action
    @objc func sendNoteClick(sender : UIButton!){

        let ac = UIAlertController(title: "Send Note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0].text
            // do something interesting with "answer" here
            print("send note \(sender.tag) - \(answer ?? "")")

            // send to server
            if NetworkReachabilityManager()!.isReachable{
                //Authenticate with server
                let user = self.prefs.string(forKey: "account") ?? "empty"
                let password = self.prefs.string(forKey: "password") ?? "empty"

                let parameters = [
                    "customerCode": user,
                    "note": answer ?? "",
                    "invoiceNumber": self.serviceCalls[sender.tag].mInvoiceNumber
                ]

                var headers : HTTPHeaders = [:]
                if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                    headers[authorizationheader.key] = authorizationheader.value
                }

                Alamofire.request(ViewController.BASEURL + "saveNote", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{
                    response in
                    if response.result.isSuccess{
                        let alertController = UIAlertController(title: "Service Calls", message:
                            "Your notes were added to your next service order.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Close", style: .default))

                        self.present(alertController, animated: true, completion: nil)
                    }
                }

            }
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            print("Cancel note")
        }))
        ac.addAction(submitAction)

        present(ac, animated: true)


    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceCalls.count
    }

    func getServiceCalls(){
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }

            Alamofire.request(ViewController.BASEURL + "customerInvoices/\(user)", method: .post, headers: headers).response{
                response in
                do {
                    let jsonDecoder = JSONDecoder()
                    if let jsonData = response.data {
                        let svc = try jsonDecoder.decode([ServiceCall].self, from: jsonData)
                        self.serviceCalls = svc
                        self.serviceCallsTV.reloadData()
                    }

                }
                catch{
                    print("Error fetching data")
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
