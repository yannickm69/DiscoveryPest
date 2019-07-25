//
//  ServicesViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/25/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ServicesViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var label: UILabel!
    var childNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = childNumber
        
        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
