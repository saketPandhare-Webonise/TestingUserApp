//
//  ViewProfileViewModel.swift
//  GymShim
//

import Foundation
import ObjectMapper

@objc protocol ApiCallDelegate {
    func onSuccess()
    func onFailure(error:String)
}

@objc protocol LogoutDelegate {
    func clearSavedData()
}

class ViewProfileViewModel {
    var userProfileModel: ViewProfileModel = ViewProfileModel()
    weak var apiCallDelegate: ApiCallDelegate?
    weak var logoutDelegate: LogoutDelegate?
    /**
     Hits view profile api call
     
     - parameter authenticationToken: authentication token of user is sent as parameter to hit api
     */
    func viewProfileApiCall(authenticationToken: String) {
        let parameters = [
            RequestParameters.AUTH_TOKEN : authenticationToken,
            RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage()
        ]
        WebserviceHandler().callWebService(WebServiceUrls.USER_PROFILE_URL(), methodType: WebServiceType.GET, parameters: parameters, succeess: { (response, headerFields) in
            self.mapResponseToModel(response)
            self.apiCallDelegate?.onSuccess()
        }) { (error) in
            
        }
    }
    
    /**
     Maps response to profile model
     
     - parameter response: response from api call which is to be mapped
     */
    func mapResponseToModel(response: AnyObject?) {
        self.userProfileModel = Mapper<ViewProfileModel>().map(response)!
    }
    
    /**
     Get user details object
     
     - returns: returns user object
     */
    func getUserDetailsObject() -> UserDetails {
        let userDetails = UserDetails()
        userDetails.name = userProfileModel.user.userName
        userDetails.email = userProfileModel.user.userEmail
        userDetails.mobileNo = userProfileModel.user.mobileNo
        userDetails.anniversaryDate = userProfileModel.user.anniversaryDate
        userDetails.dob = userProfileModel.user.dob
        userDetails.avatar = userProfileModel.user.avatar
        userDetails.profileId = userProfileModel.user.userProfileID
        return userDetails
    }
    
    /**
     Get gym trials array
     
     - returns: returns gym trials of an user
     */
    func getMyTrialsArray() -> [GymTrials] {
        return userProfileModel.user.arrayGymTrials
    }
    
    /**
     logOut API Call
     
     - parameter token: token
     */
    func logoutUser() {
        let requestParameters = [
            RequestParameters.AUTH_TOKEN : userLoginToken,
            RequestParameters.REG_ID : userRegistrationID
        ]
        WebserviceHandler().callWebService(WebServiceUrls.LOG_OUT(),methodType :WebServiceType.DELETE , parameters:requestParameters, succeess: {
            (response) in
            self.logoutDelegate?.clearSavedData()
            }, failure: { (error) in
        })
    }
    
//    /// API to remove user that is registered to receive Notification
//    func logOutFromNotificationAPI() {
//
//        if (!userRegistrationID.isEmpty){
//        let notificationInfo = [RequestParameters.REG_ID : userRegistrationID]
//        let requestParameters = [
//            RequestParameters.AUTH_TOKEN : userLoginToken,
//            RequestParameters.NOTIFICATION : notificationInfo
//        ]
//        WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(),methodType :WebServiceType.DELETE , parameters:requestParameters, succeess: {
//            (response) in
//            self.logoutUser(userLoginToken)
//            }, failure: { (error) in
//        })
//      }
//        else {
//             self.logoutUser(userLoginToken)
//        }
//    }
}
