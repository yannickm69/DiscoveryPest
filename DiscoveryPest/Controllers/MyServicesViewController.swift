//
//  MyServicesViewController.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/25/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyServicesViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicesViewController") as! ServicesViewController
        child1.childNumber = "One"
        
        let child2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicesViewController") as! ServicesViewController
        child2.childNumber = "Two"
        
        return [child1, child2]
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
