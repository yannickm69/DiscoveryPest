//
//  AuthnetReceipt.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 8/2/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import Foundation
struct AuthNetReceipt : Codable{
    var customerId : String = ""
    var billingName : String = ""
    var billingAddress : String = ""
    var billingCityStateZip : String = ""
    var total : Decimal = 0
    var description : String = ""
    var cc4digits : String = ""
    var authCode : String = ""
    var customerCode : String = ""
    var propertyName : String = ""
    var cc_response : String = ""
}
