//
//  ServiceCall.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/31/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import Foundation

struct ServiceCall : Codable {
    var mInvoiceId : integer_t = 0
    var mInvoiceNumber : String = ""
    var mServiceId : integer_t = 0
    var mCustomerId : integer_t = 0
    var mTechRef : String = ""
    var mServiceDate : String = ""
    var mServiceTimeIn : String = ""
    var mServiceTimeOut : String = ""
    var mServiceAmount : Decimal = 0.00
    var mTax : Decimal = 0.00
    var mFuelSurcharge : Decimal = 0.00
    var mPaymentReceivedDate : String = ""
    var mInvoiceDate : String = ""
    var mInvoiceType : String = ""
    var mServiceNotes : String = ""
    var mFinalized : Bool = false
    var mLastModified : String = ""
    var mModifiedBy : String = ""
    var mOriginalInvoice : String = ""
    var mFieldNotes : String = ""
    var mOriginalServiceDate : String = ""
    var mPostedDate : String = ""
    var mSprayedLocation : String = ""
    var mService : String = ""
    var mTroubleCallReason : String = ""
    var mServiceTime : String = ""
    var mAddress1 : String = ""
    var mAddress2 : String = ""
    var mCity : String = ""
    var mState : String = ""
    var mZip : String = ""
    var mUploaded : Bool = false
    var mSignatureData : String = ""
    var mTotal : Decimal = 0.00
    var mComp : String = ""
    var mPaid : Bool = false
}
