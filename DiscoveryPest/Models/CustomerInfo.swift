//
//  CustomerInfo.swift
//  DiscoveryPest
//
//  Created by user157258 on 7/5/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import Foundation

class CustomerInfo : Codable {
    var mId : integer_t = 0
    var mCustomerCode : String = ""
    var mPropertyName = ""
    var mPropertyLastName = ""
    var mPropertyAddress1 = ""
    var mPropertyAddress2 = ""
    var mPropertyCity = ""
    var mPropertyState = ""
    var mPropertyZip = ""
    var mPropertyPhoneHome = ""
    var mPropertyPhoneWork = ""
    var mPropertyEmail = ""
    var mBillingName = ""
    var mBillingLastName = ""
    var mBillingAddress1 = ""
    var mBillingAddress2 = ""
    var mBillingCity = ""
    var mBillingState = ""
    var mBillingZip = ""
    var mBillingPhoneHome = ""
    var mBillingPhoneWork = ""
    var mBillingEmail = ""
    var mInvoiceMemo = ""
    var mStartDate = ""
    var mEndDate = ""
    var mCancelDate = ""
    var mCancelReasonRef = ""
    var mSigned = ""
    var mPaymentMethod = ""
    var mSignedType = ""
    var mAutoPay = ""
    var mFullName = ""
    var mBalance : Double = 0.0
    var mNotifyPropertyMail = false
    var mNotifyPropertyEmail = false
    var mNotifyBillingMail = false
    var mNotifyBillingEmail = false
    var mEmailStatements = ""
    var mCCCode = ""
}
