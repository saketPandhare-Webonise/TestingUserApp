//
//  HomeScreenModel.swift
//  GymShim

import UIKit
import ObjectMapper

class HomeScreenModel: Mappable {

    var dictionaryTrialsAndMembership = TrialsAndMembershipModel()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryTrialsAndMembership <- map[ProfileMappableParsingConstant.TRIALS_AND_MEMBERSHIPS]
    }
}

class TrialsAndMembershipModel: Mappable {
    
    var membershipDetails = [MembershipDetailsArray]()
    var dictionaryUnreadCount = NotificationUnreadCount()
    var gymTrialsArray = [GymTrials]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        membershipDetails <- map[HomeScreenMappableConstants.MYMEMBERSHIPS]
        dictionaryUnreadCount <- map[HomeScreenMappableConstants.META]
        gymTrialsArray <- map[ProfileMappableParsingConstant.TRIALS]
    }
    
}

class MembershipDetailsArray: Mappable {
    var membershipID: Int = 0
    var membershipNumber: String = ""
    var membershipStartDate: String = ""
    var membershipEndDate: String = ""
    var membershipTotalSessions: Int = 0
    var membershipRemainingSessions: Int = 0
    var gymName: String = ""
    var planName: String = ""
    var dictionarySchedule: Schedule?
    
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
        dictionarySchedule <- map[HomeScreenMappableConstants.SCHEDULE]
    }
}

class Schedule: Mappable {
    var sessionDay: String = ""
    var sessionTime: String = ""
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        sessionDay <- map[HomeScreenMappableConstants.SESSION_DAY]
        sessionTime <- map[HomeScreenMappableConstants.SESSION_TIME]
    }
}

class NotificationUnreadCount: Mappable {
    var unreadCount: Int = 0
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        unreadCount <- map[HomeScreenMappableConstants.UNREAD_COUNT]
    }
    
}
