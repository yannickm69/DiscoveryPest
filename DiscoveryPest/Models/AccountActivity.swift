//
//  File.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/1/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import Foundation

struct AccountActivity : Codable {
    var mAmount : Decimal = 0.00
    var mTransactionType : String = ""
    var mDisplayDate : String = ""
    var mTechRef : String = ""
    var mInvoiceNumber : String = ""
}
