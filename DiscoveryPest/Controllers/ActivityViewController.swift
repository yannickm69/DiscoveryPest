//
//  ActivityViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/30/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class ActivityViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var toDate: UITextField!
    private var datePicker : UIDatePicker?
    private var datePicker2 : UIDatePicker?
    private let dateFormatter = DateFormatter()
    @IBOutlet weak var resultTableView: UITableView!
    var activities = [AccountActivity]()
    let prefs = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(UINib(nibName: "ActivityTVC", bundle: nil), forCellReuseIdentifier: "activityCustomCell")
        resultTableView.rowHeight = 30.0

        dateFormatter.dateFormat = "MM/dd/yyyy"

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date

        datePicker2 = UIDatePicker()
        datePicker2?.datePickerMode = .date

        fromText.inputView = datePicker
        toDate.inputView = datePicker2

        fromText.text = dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date())
        toDate.text = dateFormatter.string(from: Date())

        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker2?.addTarget(self, action: #selector(dateChanged2(datePicker:)), for: .valueChanged)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Do any additional setup after loading the view.
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ACTIVITY")
    }

    @objc func dateChanged(datePicker : UIDatePicker){
        fromText.text = dateFormatter.string(from: datePicker.date)

    }

    @objc func dateChanged2(datePicker : UIDatePicker){
        toDate.text = dateFormatter.string(from: datePicker.date)

    }

    @IBAction func getData(_ sender: Any) {
        getActivities()
        view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCustomCell", for: indexPath) as! ActivityTVC
        let row = activities[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "MM/dd/yyyy"
        if let sdate = dateFormatter.date(from: row.mDisplayDate){
            cell.serviceDate.text = printFormatter.string(from: sdate)
        }else{
            cell.serviceDate.text = row.mDisplayDate
        }
        cell.invoiceNumber.text = row.mInvoiceNumber
        cell.transactionType.text = row.mTransactionType

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amount = row.mAmount as NSNumber
        
        // turn red if debit
        cell.amount.textColor = row.mTransactionType.contains("Debit") ? UIColor.red : UIColor.black

        cell.amount.text = formatter.string(from: amount)

        return cell


    }

    @objc func tapGesture(gestureRecognizer:UITapGestureRecognizer){
        view.endEditing(true)
    }

    //MARK: - get data from API
    func getActivities(){
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }

            let parameters: Parameters = [
                "mFrom": fromText.text ?? "",
                "mTo": toDate.text ?? ""
            ]
            
            Alamofire.request(ViewController.BASEURL + "customerTransactions/\(user)", method: .post, parameters: parameters , encoding: JSONEncoding.default, headers: headers).response{
                response in
                do {
                    let jsonDecoder = JSONDecoder()
                    if let jsonData = response.data {
                        let act = try jsonDecoder.decode([AccountActivity].self, from: jsonData)
                        self.activities = act
                        self.resultTableView.reloadData()
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
