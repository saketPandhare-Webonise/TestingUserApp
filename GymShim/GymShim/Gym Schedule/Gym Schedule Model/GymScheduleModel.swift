//
//  GymScheduleModel.swift
//  GymShim
//

import Foundation
import ObjectMapper

class GymScheduleModel: Mappable {
    var dictionaryMemberships = MembershipData()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryMemberships <- map[ProfileMappableParsingConstant.MEMBERSHIP]
    }
}

class MembershipData: Mappable{
    var membershipID: Int = 0
    var membershipNumber: String = ""
    var membershipStartDate: String = ""
    var membershipEndDate: String = ""
    var membershipTotalSessions: Int = 0
    var membershipRemainingSessions: Int = 0
    var gymName: String = ""
    var planName: String = ""
    var isPooledMembershipAvailable:Bool = false
    var arrayPooledMembership = [PooledMembershipData]()
    var dictionaryGymSchedule = GymSchedule()
    
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
        arrayPooledMembership <- map[HomeScreenMappableConstants.POOLED_MEMBERSHIP]
        dictionaryGymSchedule <- map[ScheduleParsingConstant.GYM_SCHEDULE]
    }
}

class GymSchedule: Mappable {
    var weekDayNumber:Int = 0
    var dictionaryWeekDaysSchedule = WeekDaysSchedule()
    
    init(){}
    
    required init?(_ map: Map){}

    func mapping(map: Map) {
        weekDayNumber <- map[ScheduleParsingConstant.TODAY]
        dictionaryWeekDaysSchedule <- map[ScheduleParsingConstant.WEEK_DAYS]
    }
}

class WeekDaysSchedule: Mappable {
    var arraySundayGymScheduleInfo = [GymScheduleInfo]()
    var arrayMondayGymScheduleInfo = [GymScheduleInfo]()
    var arrayTuesdayGymScheduleInfo = [GymScheduleInfo]()
    var arrayWednesdayGymScheduleInfo = [GymScheduleInfo]()
    var arrayThursdayGymScheduleInfo = [GymScheduleInfo]()
    var arrayFridayGymScheduleInfo = [GymScheduleInfo]()
    var arraySaturdayGymScheduleInfo = [GymScheduleInfo]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        arraySundayGymScheduleInfo <- map[ScheduleParsingConstant.SUNDAY]
        arrayMondayGymScheduleInfo <- map[ScheduleParsingConstant.MONDAY]
        arrayTuesdayGymScheduleInfo <- map[ScheduleParsingConstant.TUESDAY]
        arrayWednesdayGymScheduleInfo <- map[ScheduleParsingConstant.WEDNESDAY]
        arrayThursdayGymScheduleInfo <- map[ScheduleParsingConstant.THURSDAY]
        arrayFridayGymScheduleInfo <- map[ScheduleParsingConstant.FRIDAY]
        arraySaturdayGymScheduleInfo <- map[ScheduleParsingConstant.SATURDAY]
    }
}

class GymScheduleInfo: Mappable {
    var time: String = ""
    var activityName: String = ""
    var arrayListTrainers = [TrainerInfo]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        time <- map[ScheduleParsingConstant.TIME]
        activityName <- map[ScheduleParsingConstant.ACTIVITY_NAME]
        arrayListTrainers <- map[ScheduleParsingConstant.TRAINERS]
    }
}

class TrainerInfo: Mappable {
    var trainerName: String = ""
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        trainerName <- map[ScheduleParsingConstant.TRAINER_NAME]
    }
}
