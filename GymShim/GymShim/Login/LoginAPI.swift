//
//  LoginAPI.swift
//  GymShim

import UIKit

extension LoginVC {
    
    /// This Function is used for login user into the app
    ///
    /// - parameter loginID:  EmailID
    /// - parameter password: password
    func callloginAPI(loginID: String, password: String) {
        let userInfo = [RequestParameters.LOGIN : loginID, RequestParameters.PASSWORD : password]
        let user = [RequestParameters.USER : userInfo ]
        /// initial set up of userdefaults
        isDeviceTokenRegistered = false
        notificationBadgeCount = 0
        webserviceHandler.callWebService(WebServiceUrls.LOGIN_URL(), methodType: WebServiceType.POST, parameters: user, succeess: { (response, headerFields) in
            if let loginToken: String = (response?.valueForKeyPath(ResponseParameters.INFO)!.valueForKeyPath(ResponseParameters.AUTH_TOKEN))! as? String {
                userLoginToken = loginToken
                self.registerUserForNotification(userLoginToken)
            }
            if let name: String = (response?.valueForKeyPath(ResponseParameters.USER)!.valueForKeyPath(ResponseParameters.NAME))! as? String {
                userName = name
            }
            if let resetPassword: Bool = (response?.valueForKeyPath(ResponseParameters.USER)!.valueForKeyPath(ResponseParameters.IS_RESET_PASSWORD) as? Bool) {
                isResetPassword = resetPassword
            }
            if let loginCount: Int = (response?.valueForKeyPath(ResponseParameters.USER)!.valueForKeyPath(ResponseParameters.SIGN_IN_COUNT) as? Int)! {
                signInCount = loginCount
            }
            if let avatarPresent: Bool = (response?.valueForKeyPath(ResponseParameters.USER)!.valueForKeyPath(ResponseParameters.IS_AVATAR_PRESENT) as? Bool)! {
                isAvatarPresent = avatarPresent
            }
            if let userId: String = (response?.valueForKeyPath(ResponseParameters.USER)?.valueForKeyPath(ResponseParameters.NUMBER))! as? String {
                userID = userId
            }
            self.changeRootViewController()
            }, failure: {  (error) in
               CommonHelper().showToastMessageOn(self.view, message: ValidationConstants.INVALID_CREDENTIALS)
        })
    }
    
    
    /// This method is used to register user to receive Notification
    ///
    /// - parameter authToken: authenticationToken After Login
    func registerUserForNotification(authToken: String){
        if (!deviceToken.isEmpty){
            let notificationInfo = [RequestParameters.OS : StringUtilsConstant.OS, RequestParameters.REG_ID : deviceToken]
            let userInfo = [RequestParameters.NOTIFICATION : notificationInfo, RequestParameters.AUTH_TOKEN:userLoginToken]
            webserviceHandler.callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.POST, parameters: userInfo, succeess: {(response, headerFields) in

                if let regestrationID: String = (response?.valueForKeyPath(ResponseParameters.AUTHENTICATION)!.valueForKeyPath(StringUtilsConstant.NOTIFICATION_REG_ID))! as? String {
                    userRegistrationID = regestrationID
                    isDeviceTokenRegistered = true 
                }
                }, failure: {_ in
            })
        } else {
            userRegistrationID = ""
        }
    }
}
