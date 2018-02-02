//
//  ForgotPasswordAPI.swift
//  GymShim
//

import Foundation

protocol ShowSuccessMessage {
    func resetPasswordMailSend(email: String)
}
protocol ShowErrorMessage {
    func errorSendingMail()
}
class ForgotPasswordAPI: NSObject {
    var showSuccessMessageDelegate : ShowSuccessMessage?
    var errorMessageDelegate : ShowErrorMessage?
    
    /*
       This method is used to call API for forgot password
      Parameters:
      emailID: User email id
      view: Forgot password view
     */
    func forgotPassword (emailID : String, view:UIView){
        
        let requestParameters = NSMutableDictionary()
        requestParameters.setValue(emailID, forKey: RequestParameters.EMAIL)
        // wrapping to make it an object
        let userLoginParameters = NSMutableDictionary()
        userLoginParameters.setValue(requestParameters, forKey: RequestParameters.USER)
        
        WebserviceHandler().callWebService(WebServiceUrls.RESET_PASSWORD(), methodType: WebServiceType.POST , parameters:userLoginParameters, succeess: {(response) in
            // print("response \(response as! NSDictionary)")
            self.showSuccessMessageDelegate?.resetPasswordMailSend(emailID)
            
            }, failure: {   (error) in
                CommonHelper.jsonSerializationErrorHandler(error, view:view)
                print("error has \(error)")
        })
    }
    
}
