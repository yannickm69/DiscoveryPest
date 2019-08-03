//
//  ServiceTableViewCell.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/30/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var initialRate: UILabel!
    @IBOutlet weak var regularRate: UILabel!
    @IBOutlet weak var frequency: UILabel!
    @IBOutlet weak var schedOption: UILabel!
    @IBOutlet weak var lastService: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
