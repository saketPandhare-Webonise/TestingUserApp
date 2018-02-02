//
//  ViewProfileModel.swift
//  GymShim
//

import Foundation
import ObjectMapper

class ViewProfileModel: Mappable {
    var user: User = User()
   
    init(){}

    required init?(_ map: Map){}

    func mapping(map: Map) {
        user <- map[ProfileMappableParsingConstant.USER]
    }
}

class User: Mappable {
    var userProfileID: Int = 0
    var gender: String = ""
    var dob: String = ""
    var anniversaryDate: String = ""
    var avatar: String = ""
    var userName: String = ""
    var userID: Int = 0
    var mobileNo: String = ""
    var userEmail: String = ""
    var isVerified: Bool = false
    var arrayShortlistedGyms = [ShortlistedGymsArray]()
    var dictionaryUserProfile: UserProfileDictionary = UserProfileDictionary()
    var arrayUserReviews = [GymReviews]()
    var arrayMyMembership = [GymMembership]()
    var arrayGymTrials = [GymTrials]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        userProfileID <- map[ProfileMappableParsingConstant.USER_ID]
        userName <- map[ProfileMappableParsingConstant.USER_NAME]
        userID <- map[ProfileMappableParsingConstant.USER_ID]
        mobileNo <- map[ProfileMappableParsingConstant.MOBILE_NUMBER]
        userEmail <- map[ProfileMappableParsingConstant.EMAIL]
        isVerified <- map[ProfileMappableParsingConstant.VERIFIED]
        arrayShortlistedGyms <- map[ProfileMappableParsingConstant.SHORTLISTED_GYMS]
        dictionaryUserProfile <- map[ProfileMappableParsingConstant.PROFILE]
        arrayUserReviews <- map[ProfileMappableParsingConstant.REVIEW]
        arrayMyMembership <- map[ProfileMappableParsingConstant.MY_MEMBERSHIP]
        arrayGymTrials <- map[ProfileMappableParsingConstant.MY_TRIALS]
        gender <- map[ProfileMappableParsingConstant.GENDER]
        dob <- map[ProfileMappableParsingConstant.DOB]
        anniversaryDate <- map[ProfileMappableParsingConstant.ANNIVERSARY_DATE]
        avatar <- map[ProfileMappableParsingConstant.AVATAR]
    }
}

class ShortlistedGymsArray: Mappable {
    var gymID: String = ""
    var gymName: String = ""
    var gymRating: Double=0.0
    var gymAddress: String = ""
    var gymPhoneNo: String = ""
    var gymFeatured: Bool = false
    var gymSponsored: Bool = false
    var gymActualPrice: Int = 0
    var gymOfferedPrice: Int = 0
    var gymPlantype: Int = 0
    var gymPlanName: String = ""
    var gymRemainingSlot: String = ""
    var gymPlanDescription = ""
    var gymImage: String = ""
    var isActive: Bool = false
    var dictionaryGymLocation = GymLocation()
    var gymActivities = [ActivitiesList]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        gymName <- map[GymDetailsMappableConstant.NAME]
        gymRating <- map[GymDetailsMappableConstant.RATING]
        gymAddress <- map[GymDetailsMappableConstant.FULL_ADDRESS]
        gymFeatured <- map[GymDetailsMappableConstant.FEATURED]
        gymSponsored <- map[GymDetailsMappableConstant.SPONSORED]
        gymOfferedPrice <- map[GymDetailsMappableConstant.PRICE]
        gymActualPrice <- map[GymDetailsMappableConstant.OFFERED_PRICE]
        gymImage <- map[GymDetailsMappableConstant.IMAGE]
        gymRemainingSlot <- map[GymDetailsMappableConstant.REMAINING_SLOT]
        gymAddress <- map[GymDetailsMappableConstant.FULL_ADDRESS]
        dictionaryGymLocation <- map[GymDetailsMappableConstant.LOCATION]
        gymActivities <- map[GymDetailsMappableConstant.ACTIVITIES]
        gymID <- map[GymDetailsMappableConstant.ID]
        isActive <- map[GymDetailsMappableConstant.ACTIVE]
    }
}

class UserProfileDictionary: Mappable {
    var userProfileID: Int = 0
    var userName: String = ""
    var gender: String = ""
    var dob: String = ""
    var anniversaryDate: String = ""
    var avatar: String = ""
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        userProfileID <- map[ProfileMappableParsingConstant.USER_ID]
        userName <- map[ProfileMappableParsingConstant.USER_NAME]
        gender <- map[ProfileMappableParsingConstant.GENDER]
        dob <- map[ProfileMappableParsingConstant.DOB]
        anniversaryDate <- map[ProfileMappableParsingConstant.ANNIVERSARY_DATE]
        avatar <- map[ProfileMappableParsingConstant.AVATAR]
    }
}

class GymMembership: Mappable{
    var memberShipID: Int = NumberConstant.ZERO
    var memberShipNumber: String = StringUtilsConstant.EMPTY_STRING
    var gymName: String = StringUtilsConstant.EMPTY_STRING
    var memberShipStartDate: String = StringUtilsConstant.EMPTY_STRING
    var memberShipEndDate: String = StringUtilsConstant.EMPTY_STRING
    var memberShipPurchasedType: String = StringUtilsConstant.EMPTY_STRING
    var memberShipSessions: Int = NumberConstant.ZERO
    var memberShipRemainingSessions: Int = NumberConstant.ZERO
    var memberShipStatus: String = StringUtilsConstant.EMPTY_STRING
    var membershipActivity = MembershipPlan()
    var arrayMembershipUsers = [GymMembershipUsers]()
    var dictioanryPlanDetails = GymMembershipPlanDetails()
    var arrayGymActivities = [GymMembershipActivities]()
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        memberShipID <- map[HomeScreenMappableConstants.MEMBERSHIP_ID]
        memberShipNumber <- map[ProfileMappableParsingConstant.MEMBERSHIP_NO]
        gymName <- map[ProfileMappableParsingConstant.MEMBERSHIP_GYMNAME]
        memberShipStartDate <- map[ProfileMappableParsingConstant.MEMBERSHIP_START_TIME]
        memberShipEndDate <- map[ProfileMappableParsingConstant.MEMBERSHIP_END_TIME]
        memberShipPurchasedType <- map[ProfileMappableParsingConstant.MEMBERSHIP_PURCHASED_TYPE]
        memberShipSessions <- map[ProfileMappableParsingConstant.MEMBERSHIP_SESSIONS]
        arrayMembershipUsers <- map[ProfileMappableParsingConstant.MEMBERS]
        dictioanryPlanDetails <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_DETAIL]
        memberShipStatus <- map[ProfileMappableParsingConstant.MEMBERSHIP_STATUS]
        memberShipRemainingSessions <- map[ProfileMappableParsingConstant.REMAINING_SESSIONS]
        arrayGymActivities <- map[ProfileMappableParsingConstant.ACTIVITY_IMAGES]
        membershipActivity <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN]
    }
}

class GymMembershipActivities: Mappable {
    var activityName: String = StringUtilsConstant.EMPTY_STRING
    var activityIcon: String = StringUtilsConstant.EMPTY_STRING
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        activityName <- map[ProfileMappableParsingConstant.GYM_ACTIVITY_NAME]
        activityIcon <- map[ProfileMappableParsingConstant.GYM_ACTIVITY_ICON]
    }
}

class GymMembershipUsers: Mappable {
    var memberShipUserName: String = StringUtilsConstant.EMPTY_STRING
    var memberShipUserMobileNo: String = StringUtilsConstant.EMPTY_STRING
    var memberShipUserEmail: String = StringUtilsConstant.EMPTY_STRING
    var memberShipBurnedSession: Int = NumberConstant.ZERO
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        memberShipUserName <- map[ProfileMappableParsingConstant.MEMBER_FULL_NAME]
        memberShipUserMobileNo <- map[ProfileMappableParsingConstant.MEMBER_MOBILE_NO]
        memberShipUserEmail <- map[ProfileMappableParsingConstant.MEMBERSHIP_EMAIL]
        memberShipBurnedSession <- map[ProfileMappableParsingConstant.MEMBERSHIP_BURNED_SESSION]
    }
}

class GymMembershipPlanDetails: Mappable {
    var memberShipPlanType: String = StringUtilsConstant.EMPTY_STRING
    var memberShipPlanMonth: Int = NumberConstant.ZERO
    var memberShipPlanBasePrice: String = StringUtilsConstant.EMPTY_STRING
    var memberShipPlanDiscountPrice: String = StringUtilsConstant.EMPTY_STRING
    var membershipIsSponsered: Bool = false
    var memberShipSoldPrice: String = StringUtilsConstant.EMPTY_STRING
    var membershipAllowPooling: Bool = false
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        memberShipPlanType <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_TYPE]
        memberShipPlanMonth <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_MONTHS]
        memberShipPlanBasePrice <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_BASEPRICE]
        memberShipPlanDiscountPrice <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_DISCOUNTED_PRICE]
        membershipIsSponsered <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_SPONSORED]
        memberShipSoldPrice <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_SOLD]
        membershipAllowPooling <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN_ALLOW_POOLING]
    }
}

class GymLocation: Mappable {
    var lat: String = StringUtilsConstant.EMPTY_STRING
    var lng: String = StringUtilsConstant.EMPTY_STRING
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        lat <- map[GymDetailsMappableConstant.LATITUDE]
        lng <- map[GymDetailsMappableConstant.LONGITUDE]
    }
}

class ActivitiesList: Mappable {
    var activityName: String = StringUtilsConstant.EMPTY_STRING
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        activityName <- map[ProfileMappableParsingConstant.USER_NAME]
    }
}

class GymReviews: Mappable {
    var id : Int = NumberConstant.ZERO
    var comment: String = StringUtilsConstant.EMPTY_STRING
    var rating: Double = Double(NumberConstant.ZERO)
    var reviewerName: String = StringUtilsConstant.EMPTY_STRING
    var reviewableName: String = StringUtilsConstant.EMPTY_STRING
    var reviewerIcon: String = StringUtilsConstant.EMPTY_STRING
    var reviewableIcon: String = StringUtilsConstant.EMPTY_STRING
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        id <- map[ProfileMappableParsingConstant.USER_ID]
        comment <- map[ProfileMappableParsingConstant.COMMENT]
        rating <- map[GymDetailsMappableConstant.RATING]
        reviewerName <- map[ProfileMappableParsingConstant.REVIEWER_NAME]
        reviewableName <- map[ProfileMappableParsingConstant.REVIEWABLE_NAME]
        reviewerIcon <- map[ProfileMappableParsingConstant.REVIEWER_ICON]
        reviewableIcon <- map[ProfileMappableParsingConstant.REVIEWABLE_ICON]
    }
}

class GymTrials: Mappable {
    var trialId: Int = NumberConstant.ZERO
    var trialNumber: String = StringUtilsConstant.EMPTY_STRING
    var gymName: String = StringUtilsConstant.EMPTY_STRING
    var trialDate: String = StringUtilsConstant.EMPTY_STRING
    var memberShipStatus: String = StringUtilsConstant.EMPTY_STRING
    var membershipActivity = MembershipPlan()
    var trialTime: String = StringUtilsConstant.EMPTY_STRING
    var arrayGymActivities = [GymMembershipActivities]()
    var trialStatus: Int = NumberConstant.ZERO
    var trialType: String = StringUtilsConstant.EMPTY_STRING
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        trialId <- map[ProfileMappableParsingConstant.USER_ID]
        trialNumber <- map[ProfileMappableParsingConstant.MEMBERSHIP_NO]
        gymName <- map[ProfileMappableParsingConstant.MEMBERSHIP_GYMNAME]
        trialDate <- map[ProfileMappableParsingConstant.TRIAL_DATE]
        trialTime <- map[ProfileMappableParsingConstant.TRIAL_TIME]
        memberShipStatus <- map[ProfileMappableParsingConstant.TRIAL_STATUS]
        membershipActivity <- map[ProfileMappableParsingConstant.MEMBERSHIP_PLAN]
        arrayGymActivities <- map[ProfileMappableParsingConstant.ACTIVITY_IMAGES]
        trialStatus <- map[ProfileMappableParsingConstant.TRIAL_ATTENDANCE_STATUS]
        trialType <- map[ProfileMappableParsingConstant.TRIAL_STATUS]
    }
}

class MembershipPlan: Mappable {
    var planName: String = StringUtilsConstant.EMPTY_STRING
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        planName <- map[ProfileMappableParsingConstant.GYM_ACTIVITY_NAME]
    }
}

class UserDetails {
    var name: String?
    var email: String?
    var mobileNo: String?
    var dob: String?
    var anniversaryDate: String?
    var avatar: String?
    var profileId: Int?
}

class UserSingleTrial: Mappable {
    
    var dictionaryUserTrial = GymTrials()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryUserTrial <- map[FeedBackMappableConstant.TRIAL]
    }
}

class PastUserTrials: Mappable {
    var arrayGymTrials = [GymTrials]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        arrayGymTrials <- map[ProfileMappableParsingConstant.MY_TRIALS]
    }
}



