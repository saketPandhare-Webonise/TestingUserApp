//
//  MemberShipDetailModel.swift
//  GymShim


import UIKit
import ObjectMapper

class MemberShipDetailModel: Mappable {
    var dictionaryMembershipDetail =  MembershipDetails()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryMembershipDetail <- map[ProfileMappableParsingConstant.MEMBERSHIP]
    }
}

class MembershipDetails: Mappable {
    var membershipID: Int = 0
    var membershipNumber: String = ""
    var membershipStartDate: String = ""
    var membershipEndDate: String = ""
    var membershipTotalSessions: Int = 0
    var membershipRemainingSessions: Int = 0
    var gymName: String = ""
    var planName: String = ""
    var isPooledMembershipAvailable:Bool = false
    var arrayAttendance = [UserGymAttendance]()
    var arrayMembershipTiming = [MembershipTiming]()
    var arrayPooledMembership = [PooledMembershipData]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        membershipID <- map[HomeScreenMappableConstants.MEMBERSHIP_ID]
        membershipNumber <- map[HomeScreenMappableConstants.MEMBERSHIP_NUMBER]
        membershipStartDate <- map[HomeScreenMappableConstants.MEMBERSHIP_START_DATE]
        membershipEndDate <- map[HomeScreenMappableConstants.MEMBERSHIP_END_DATE]
        membershipTotalSessions <- map[HomeScreenMappableConstants.MEMBERSHIP_TOTAL_SESSIONS]
        membershipRemainingSessions <- map[HomeScreenMappableConstants.MEMBERSHIP_REMAINING_SESSIONS]
        gymName <- map[HomeScreenMappableConstants.GYM_NAME]
        planName <- map[HomeScreenMappableConstants.GYM_PLANNAME]
        isPooledMembershipAvailable <- map[HomeScreenMappableConstants.IS_POOLED_MEMBERSHIP]
        arrayAttendance <- map[HomeScreenMappableConstants.ATTENDANCE_DATES]
        arrayMembershipTiming <- map[HomeScreenMappableConstants.MEMBERSHIP_TIMINGS]
        arrayPooledMembership <- map[HomeScreenMappableConstants.POOLED_MEMBERSHIP]
    }
}

class PooledMembershipData: Mappable {
    
    var pooledMemberName: String = ""
    var pooledRemainingSessions: Int = 0
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        pooledMemberName <- map[HomeScreenMappableConstants.POOLED_NAME]
        pooledRemainingSessions <- map[HomeScreenMappableConstants.POOLED_REMAINING_SESSION]
    }
}

class UserGymAttendance: Mappable {
    var date:Int = 0
    var status:Int = 0
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        date <- map[HomeScreenMappableConstants.DATE]
        status <- map[HomeScreenMappableConstants.STATUS]
    }
}

class MembershipTiming: Mappable {
    var day:String = ""
    var time:String = ""
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        day <- map[HomeScreenMappableConstants.SESSION_DAY]
        time <- map[HomeScreenMappableConstants.SESSION_TIME]
    }
    
}
