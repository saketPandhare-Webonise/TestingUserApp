//
//  FeedBackModel.swift
//  GymShim


import UIKit
import ObjectMapper

class FeedBackModel: Mappable {
    
    var arrayFeedBacks = [FeedBackList]()
    var dictionaryFeedBackCount = FeedBackMetaData()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        arrayFeedBacks <- map[FeedBackMappableConstant.FEEDBACKS]
        dictionaryFeedBackCount <- map[FeedBackMappableConstant.META]
    }
}

class FeedBackList: Mappable {
    
    var id:Int = 0
    var title:String = ""
    var userComment:String = ""
    var reviewerName:String = ""
    var revivedGymName:String = ""
    var reviewerImage:String = ""
    var revivedGymImage:String = ""
    var feedBackTime:Double = 0.0
    var feedBackUpdatedTime:Int = 0
    var dictionaryGymComment = GymReview()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        id <- map[FeedBackMappableConstant.ID]
        title <- map[FeedBackMappableConstant.REVIEW_TITLE]
        userComment <- map[FeedBackMappableConstant.COMMENT]
        reviewerName <- map[FeedBackMappableConstant.REVIEWER_NAME]
        revivedGymName <- map[FeedBackMappableConstant.REVIVED_GYMNAME]
        reviewerImage <- map[FeedBackMappableConstant.REVIEWER_ICON]
        feedBackTime <- map[FeedBackMappableConstant.REVIEW_CREATED_TIME]
        feedBackUpdatedTime <- map[FeedBackMappableConstant.REVIEW_UPDATED_TIME]
        dictionaryGymComment <- map[FeedBackMappableConstant.GYMFEED_BACK]
    }
}

class GymReview: Mappable {
    
    var id:Int = 0
    var gymComment:String = ""
    var reviewTime:Double = 0.0
    var reviewUpdatedTime:Int = 0
    var isViewed:Bool = true
    
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        id <- map[FeedBackMappableConstant.ID]
        gymComment <- map[FeedBackMappableConstant.COMMENT]
        reviewTime <- map[FeedBackMappableConstant.REVIEW_CREATED_TIME]
        reviewUpdatedTime <- map[FeedBackMappableConstant.REVIEW_UPDATED_TIME]
        isViewed <- map[FeedBackMappableConstant.FEEDBACK_VIEWED]
    }
}

class FeedBackMetaData: Mappable {
    
    var totalFeedBack: Int = 0
    var unReadCount: Int = 0
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        totalFeedBack <- map[FeedBackMappableConstant.TOTAL]
        unReadCount <- map [HomeScreenMappableConstants.UNREAD_COUNT]
    }
}

class UserSingleFeedBack: Mappable {
    
    var dictionaryUserFeedBack = FeedBackList()

    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        dictionaryUserFeedBack <- map[FeedBackMappableConstant.FEEDBACK]
    }
}
