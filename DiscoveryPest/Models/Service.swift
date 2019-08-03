//
//  Service.swift
//  DiscoveryPest
//
//  Created by yannick mollard on 7/30/19.
//  Copyright © 2019 Gwenn&Du Apps. All rights reserved.
//

import Foundation

struct Service : Codable {
    var mServiceId : integer_t = 0
    var mCancelDate : String = ""
    var mServiceType : String = ""
    var mInitialRate : String = ""
    var mRegularRate : String = ""
    var mFrequencyRef : String = ""
    var mDropStr : String = ""
    var mLastServiceDate : String = ""
    var mSchedOption : String = ""
    var mScheduleStart : String = ""
    var mSchedDayOfMonth : String = ""
    var mSchedDayOfMonthCount : String = ""
    var mSchedDayOfMonthWeekday : String = ""
    var mFreq : String = ""
}
