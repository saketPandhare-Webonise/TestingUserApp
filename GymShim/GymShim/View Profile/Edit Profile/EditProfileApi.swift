//
//  EditProfileApi.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

protocol NavigateToProfileDelegate {
    func navigateToProfile()
    func onFailToUpdate(error: AnyObject)
}

protocol RemovePhotoDelegate {
    func successfulRemovalOfProfilePhoto()
    func failedToRemoveProfilePhoto(error: AnyObject)
}

class EditProfileApi: NSObject {
    var navigationDelegate: NavigateToProfileDelegate?
    var removePhotoDelegate: RemovePhotoDelegate?
    
    /**
     Method to call api of edit profile without profile picture upload
     
     - parameter email: email of username
     - parameter mobile: mobile number of user
     - parameter dob: date of birth of user
     - parameter doa: anniversary date of user
     - parameter id: id of user
     */
    func callEditProfileApiWithoutImage(email: String, mobile: String, dob: String, doa: String, id: Int) {
        
        let user = [RequestParameters.ANNIVERSARY_DATE : doa,RequestParameters.DOB: dob,RequestParameters.MOBILE_NUMBER: mobile, RequestParameters.EMAIL: email]
        
        var requestParameters = [String:AnyObject]()
        requestParameters[RequestParameters.AUTH_TOKEN] = userLoginToken
        requestParameters[RequestParameters.USER] = user
        
        WebserviceHandler().callWebService(WebServiceUrls.CHANGE_PASSWORD(), methodType: WebServiceType.PUT, parameters: requestParameters, succeess: { (response, headerFields) in
            self.navigationDelegate!.navigateToProfile()
        }) { (error) in
            self.navigationDelegate!.onFailToUpdate(error)
            }
        }
    
    /**
     Method to upload user Profile Image with user details parameters
     
     - parameter email: email of username
     - parameter mobile: mobile number of user
     - parameter dob: date of birth of user
     - parameter doa: anniversary date of user
     - parameter id: id of user
     - parameter image: user selected Image
     */
    func callWebServiceForEditProfileWithImage(email:String, mobile: String, dob: String, doa: String, id: Int, image:UIImage) {
        WebserviceHandler.uploadImageAndData(WebServiceUrls.CHANGE_PASSWORD(), methodType: WebServiceType.PUT,
                                             userImage:image, email:email, mobile: mobile, dob: dob, doa: doa, id: id,
                                             succeess: {(response, headerFields) in
                                                
                                                if ((response?.valueForKey(UserDefaultConstants.INFO)) != nil) {
                                                    self.navigationDelegate?.navigateToProfile()
                                                } else {
                                                    self.navigationDelegate!.onFailToUpdate(WebServiceErrors.UPDATE_FAILED)
                                                }
            },
                                             failure: {   (error) in
                                                self.navigationDelegate!.onFailToUpdate(error)
        })
    }
    
    /**
     Method to call api of edit profile without profile picture upload
     
    
     */
    func callApiForRemoveProfilePhoto() {
        let parameters = [RequestParameters.AUTH_TOKEN : userLoginToken]
        WebserviceHandler().callWebService(WebServiceUrls.REMOVE_IMAGE(), methodType: WebServiceType.GET, parameters: parameters, succeess: { (response, headerFields) in
            self.removePhotoDelegate?.successfulRemovalOfProfilePhoto()
        }) { (error) in
            self.removePhotoDelegate!.failedToRemoveProfilePhoto(error)
        }
    }
    
    }



