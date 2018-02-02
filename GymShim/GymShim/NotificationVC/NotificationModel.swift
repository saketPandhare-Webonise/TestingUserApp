//
//  NotificationModel.swift
//  GymShim

import UIKit
import ObjectMapper

class NotificationModel: Mappable {
     var arrayTotalNotifications = [NotificationDetails]()
     var dictionaryNotification = FeedBackMetaData()
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        arrayTotalNotifications <- map[NotificationConstant.NOTIFICATIONS]
        dictionaryNotification <- map[FeedBackMappableConstant.META]
    }
}

class NotificationDetails: Mappable {
    var notificationID: Int = 0
    var notificationTitle: String = ""
    var notificationDescription: String = ""
    var notificationType: String = ""
    var notificationResourceID: Int = 0
    var notificationTimeAgo: Double = 0
    
    init(){}
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        notificationID <- map[NotificationConstant.NOTIFICATION_ID]
        notificationType <- map[NotificationConstant.TYPE]
        notificationTitle <- map[NotificationConstant.NOTIFICATION_TITLE]
        notificationDescription <- map[NotificationConstant.NOTIFICATION_DESCRIPTION]
        notificationResourceID <- map[NotificationConstant.RESOURCE]
        notificationTimeAgo <- map[NotificationConstant.CREATED_AT]
    }
}
