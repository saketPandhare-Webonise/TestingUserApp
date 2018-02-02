//
//  NotificationViewModel.swift
//  GymShim

import UIKit
import ObjectMapper

/// Delegate Call back after response from server has been recieved
protocol NotificationAPIDelegate {
    func onSuccess()
    func resetNotificationCount()
}

class NotificationViewModel: NSObject {
    
    var notificationModel: NotificationModel = NotificationModel()
    var notificationDetails: NotificationDetails = NotificationDetails()
    var notificationAPIDelegate: NotificationAPIDelegate?
    var notificationListArray : [NotificationDetails] = []
    var perPage:Int = 10
    var pageNo:Int = 1
    
    /// API Call to get notification list
    func getUserNotification() {
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.PAGE: getPageNo(),RequestParameters.PER_PAGE: perPage,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage()]
        
        WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
            self.readAllNotification()
            self.mapResponseToModel(response)
            self.notificationAPIDelegate?.onSuccess()
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
    
    /// Webservice call to mark All notification As read
    func readAllNotification() {
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken]
        WebserviceHandler().callWebService(WebServiceUrls.NOTIFICATION_VIEW_ALL(), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
           self.notificationAPIDelegate?.resetNotificationCount()
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
    
    /**
     Maps response to profile model
     
     - parameter response: response from api call which is to be mapped
     */
    func mapResponseToModel(response: AnyObject?) {
        notificationModel = Mapper<NotificationModel>().map(response)!
        appendNotificationObjecttoArray()
    }
    
    /// Add Feedback List Object to array after Webservice call
    func appendNotificationObjecttoArray() {
        for i in 0..<self.notificationModel.arrayTotalNotifications.count  {
            notificationListArray .append(self.notificationModel.arrayTotalNotifications[i])
        }
    }
    
    /// Get Page no that needs to be send to Webservice as parameter
    ///
    /// - returns: page no count
    func getPageNo()->Int {
        return pageNo
    }
    
    /// Increment Page no for Pagination
    func incrementPageNo() {
        pageNo += 1
    }
    
    /// Get count of total number of Notification Present
    ///
    /// - returns: count of total Notification
    func getTotalNotificationPresent() -> Int{
        return self.notificationModel.dictionaryNotification.totalFeedBack
    }
    
    /// This function is used to get single Notification Object
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: NotificationDetails object
    func getSingleNotificationObject(indexPath: NSIndexPath) -> NotificationDetails{
         notificationDetails = notificationListArray[indexPath.row] 
        return notificationDetails
    }
    
    /// This function will return the type of notification [FeedBack,trial etc]
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: notificationtype
    func getNotificationType(indexPath: NSIndexPath) -> String {
        return getSingleNotificationObject(indexPath).notificationType
    }

    /// This function will return notification resource type to check for parameter to WS
    ///
    /// - parameter indexPath: Table IndexPath
    ///
    /// - returns: resourse type
    func getNotificationResourceID(indexPath: NSIndexPath) -> Int {
        return getSingleNotificationObject(indexPath).notificationResourceID
    }
    
    /// This function will return notification resource ID to check for parameter to WS
    ///
    /// - parameter indexPath: Table IndexPath
    ///
    /// - returns: resourse ID
    func getNotificationID(indexPath: NSIndexPath) -> Int{
        return getSingleNotificationObject(indexPath).notificationID
    }
    
    /// This function is used to set time for notification in notification listing screen
    ///
    /// - parameter indexPath: indexPath
    ///
    /// - returns: notification time as string
    func getNotificationTime(indexPath: NSIndexPath) -> String {
       return getTimeForFeedbackSection(getSingleNotificationObject(indexPath).notificationTimeAgo)
    }
    
    /// This function is used to get description of notification in notification listing screen
    /// - parameter indexPath: indexPath
    /// - returns: Notification description
    func getNotificationDescription(indexPath: NSIndexPath) -> String {
        return getSingleNotificationObject(indexPath).notificationDescription
    }
}
