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
        settings.style.buttonBarBackgroundColor =  UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.init(red: 1/255.0, green: 113/255.0, blue: 168/255.0, alpha: 1.0)
        settings.style.selectedBarHeight = 3

        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 12)
        settings.style.buttonBarItemTitleColor = UIColor.black

        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "svc") as! ServicesViewController
                
        let child2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scs") as! ServiceCallsVC
        
        let child3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act") as! ActivityViewController
        return [child1, child2, child3]
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
