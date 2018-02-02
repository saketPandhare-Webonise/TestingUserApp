//
//  ChangePasswordAPI.swift
//  GymShim


import UIKit

extension ChangePasswordVC {
    /**
    API Call for Change Password
     */
    func callChangePasswordAPI(currentPassword: String, newPassword: String) {
        if (!userLoginToken.isEmpty) {
        let userPassword = [RequestParameters.CURRENT_PASSWORD : currentPassword ,RequestParameters.PASSWORD : newPassword,
                            RequestParameters.CONFIRM_PASSWORD:newPassword]
        let user = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.USER:userPassword]
        WebserviceHandler().callWebService(WebServiceUrls.CHANGE_PASSWORD(), methodType: WebServiceType.PUT, parameters: user, succeess: {
            (response, headerFields) in
            isResetPassword = true
            self.performOperationAfterResponseReceived(response!)
            self.passwordChangedSuccessfullyDelegate?.passwordChangedSuccessfully()
            }, failure: { (error) in
                CommonHelper.jsonSerializationErrorHandler(error, view:self.view)
        })
      }
    }
    
    /**
     Perform Operation after response from server
     
     - parameter response: response from the server
     */
    func performOperationAfterResponseReceived(response: AnyObject) {
        if (((response.valueForKey(ResponseParameters.INFO)!.valueForKey(ResponseParameters.AUTH_TOKEN))) != nil) {
            passwordChangedSuccessfully()
        }
    }
}
