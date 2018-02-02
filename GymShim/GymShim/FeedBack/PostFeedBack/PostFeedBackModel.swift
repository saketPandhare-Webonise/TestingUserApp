//
//  PostFeedBackModel.swift
//  GymShim


import UIKit
import ObjectMapper

class PostFeedBackModel: Mappable {
    var arrayGymList = [ListGyms]()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        arrayGymList <- map[FeedBackMappableConstant.GYMS]
    }
}

class ListGyms: Mappable {
    var gymID:Int = 0
    var gymName:String = ""
    var gymSlug:String = ""
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
       gymID <- map[FeedBackMappableConstant.ID]
       gymName <- map[FeedBackMappableConstant.GYM_NAME]
       gymSlug <- map[FeedBackMappableConstant.GYM_SLUG]
    }
}
