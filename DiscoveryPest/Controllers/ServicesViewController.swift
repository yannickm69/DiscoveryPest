//
//  ServicesViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/25/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class ServicesViewController: UIViewController, IndicatorInfoProvider,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var servicesTableView: UITableView!
    var services = [Service]()
    let prefs = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.register(UINib(nibName: "ServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "serviceCustomCell")
        servicesTableView.rowHeight = 340.0
        servicesTableView.allowsSelection = false
        //servicesTableView.estimatedRowHeight = 400.0
        //load data
        getServices()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MY SERVICES")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //register custom cell

    //MARK: - tableview stuff
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCustomCell", for: indexPath) as! ServiceTableViewCell
        let s = services[indexPath.row]
        cell.title.text = s.mServiceType
        cell.serviceType.text = s.mServiceType
        cell.initialRate.text = s.mInitialRate
        cell.regularRate.text = s.mRegularRate
        cell.frequency.text = s.mFrequencyRef
        cell.schedOption.text = s.mSchedOption
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "MM/dd/yyyy"
        if let fdate = dateformatter.date(from: s.mLastServiceDate){
            cell.lastService.text = printFormatter.string(from: fdate)
        }else{
            cell.lastService.text = s.mLastServiceDate
        }
        

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    //MARK: - get data from API
    func getServices(){
        if NetworkReachabilityManager()!.isReachable{
            //Authenticate with server
            let user = prefs.string(forKey: "account") ?? "empty"
            let password = prefs.string(forKey: "password") ?? "empty"
            var headers : HTTPHeaders = [:]
            if let authorizationheader = Request.authorizationHeader(user: user, password: password){
                headers[authorizationheader.key] = authorizationheader.value
            }

            Alamofire.request(ViewController.BASEURL + "customerService/\(user)", method: .post, headers: headers).response{
                response in
                do {
                    let jsonDecoder = JSONDecoder()
                    if let jsonData = response.data {
                        let svc = try jsonDecoder.decode([Service].self, from: jsonData)
                        self.services = svc
                        self.servicesTableView.reloadData()
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
