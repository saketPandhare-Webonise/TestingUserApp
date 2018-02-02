//
//  FeedBackDetailViewModel.swift
//  GymShim

import UIKit
import ObjectMapper

protocol GymFeedBackViewedDelegate {
    func gymFeedBackViewDelegate()
    func gymFeedBackNotification()
}

class FeedBackDetailViewModel: NSObject {

    var delegateGymFeedBackViewed:GymFeedBackViewedDelegate?
    var userSingleFeedBackModel: UserSingleFeedBack = UserSingleFeedBack()
    var notificationNumber: Int = 0
    var feedBackID: Int = 0
    /**
     It marks the feedback as viewed when the user first time views the feedback
     
     - parameter feedBackId: feedback which is to be marked as viewed
     */
    func markFeedBackAsViewed(feedBackId: Int) {
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken]
        WebserviceHandler().callWebService(WebServiceUrls.FEEDBACK_REVIWED(feedBackId), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
            
            self.delegateGymFeedBackViewed?.gymFeedBackViewDelegate()
            
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
    
    
    /// This Function is called when user comes to detail page on notification click
    ///
    /// - parameter feedBackId: feedbackID
    func getFeedBackInfo(feedBackId: Int) {
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage(),RequestParameters.ID: feedBackId]
        
        WebserviceHandler().callWebService(WebServiceUrls.GET_FEEDBACK_DETAIL(feedBackId), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
            self.mapSinglePostToModel(response)
            self.delegateGymFeedBackViewed?.gymFeedBackNotification()
            
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
    
    /// This method is used to map feedback detail response to me model
    ///
    /// - parameter response: response from server
    func mapSinglePostToModel(response: AnyObject?){
        self.userSingleFeedBackModel = Mapper<UserSingleFeedBack>().map(response)!
    }
    
    /// This function will Notify Server that Notification has been read
    ///
    /// - parameter notificationID: notification number
    func notifyServerAboutNotificationViewed(notificationID: Int) {
        WebserviceHandler().notifyServerNotificationViewed(notificationID)
    }
}
