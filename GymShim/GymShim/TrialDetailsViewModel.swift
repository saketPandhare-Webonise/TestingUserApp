//
//  TrialDetailsViewModel.swift
//  GymShim


import UIKit
import ObjectMapper

protocol ShowTrialData {
    func relaodTrailTableViewAndNotifyServer()
}

class TrialDetailsViewModel: NSObject {
    
    var userSingleTrialModel = UserSingleTrial()
    var showTrialDataDelegate: ShowTrialData?
    
    
    /// This method is used to get trial data from webservice
    ///
    /// - parameter trialID: trial id received from notification
    func getTrialInfoFromNotification(trialID:Int){
        if (!userLoginToken.isEmpty) {
        let membershipDetailRequest = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.ID:trialID]
        WebserviceHandler().callWebService(WebServiceUrls.GET_TRIAL_INFO(trialID), methodType: WebServiceType.GET, parameters: membershipDetailRequest, succeess: {
            (response, headerFields) in
            
            self.mapSinglePostToModel(response)
            self.showTrialDataDelegate?.relaodTrailTableViewAndNotifyServer()
            
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
    
    /// Fpllowing code needs to be implemented currently in testing ,will get fix in next PR
    /// Map single Trial to Trial model
    ///
    /// - parameter response: Webservice Response
    func mapSinglePostToModel(response: AnyObject?){
        self.userSingleTrialModel = Mapper<UserSingleTrial>().map(response)!
    }
    
    /// This function will Notify Server that Notification has been read
    ///
    /// - parameter notificationID: notification number
    func notifyServerAboutNotificationViewed(notificationID: Int) {
        WebserviceHandler().notifyServerNotificationViewed(notificationID)
    }
}
