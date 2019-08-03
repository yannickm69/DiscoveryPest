//
//  AcitvityTVC.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/1/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit

class ActivityTVC: UITableViewCell {
    @IBOutlet weak var serviceDate: UILabel!
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var transactionType: UILabel!
    @IBOutlet weak var amount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
