//
//  ViewMoreViewModel.swift
//  GymShim
//

import Foundation
class ViewMoreViewModel {
    
    ///calls web service for push notification on
    func callWSPushNotificationSettingOn() {
        if (!deviceToken.isEmpty) {
            let notificationInfo = [
                RequestParameters.OS: StringUtilsConstant.OS,RequestParameters.REG_ID: deviceToken]
            let userInfo = [
                RequestParameters.NOTIFICATION: notificationInfo,RequestParameters.AUTH_TOKEN: userLoginToken]
            WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.POST, parameters: userInfo, succeess: {(response, headerFields) in
                if let registrationID: String = (response?.valueForKeyPath(ResponseParameters.AUTHENTICATION)!.valueForKeyPath(StringUtilsConstant.NOTIFICATION_REG_ID))! as? String {
                    userRegistrationID = registrationID
                    isDeviceTokenRegistered = true
                }
                }, failure: {_ in
            })
        } else {
            userRegistrationID = ""
        }
    }
    
    ///calls web service for push notification off
    func callWSPushNotificationSettingOff() {
        if (!deviceToken.isEmpty) {
            let notificationInfo = [
                RequestParameters.OS: StringUtilsConstant.OS,
                RequestParameters.REG_ID: deviceToken]
            let userInfo = [
                RequestParameters.NOTIFICATION: notificationInfo, RequestParameters.AUTH_TOKEN: userLoginToken]
            WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.DELETE, parameters: userInfo, succeess: {(response, headerFields) in
                    userRegistrationID = StringUtilsConstant.EMPTY_STRING
                    isDeviceTokenRegistered = false
                }, failure: {_ in
            })
        } else {
            userRegistrationID = ""
        }
    }
}
