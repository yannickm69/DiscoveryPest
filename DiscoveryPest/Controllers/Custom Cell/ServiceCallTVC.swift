//
//  ServiceCallTVC.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/31/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit

class ServiceCallTVC: UITableViewCell {
    @IBOutlet weak var mainContent: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var techRef: UILabel!
    @IBOutlet weak var serviceDate: UILabel!
    @IBOutlet weak var invoiceType: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var sprayLocation: UILabel!
    @IBOutlet weak var serviceStatus: UILabel!
    @IBOutlet weak var sendNote: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainContent.layer.borderWidth = 1
        mainContent.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
