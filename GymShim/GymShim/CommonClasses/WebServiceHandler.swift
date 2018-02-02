//
//  WebServiceHandler.swift
//  GymShim


import Foundation
import UIKit
import Alamofire

let LOADER_W_H : CGFloat = 72.0

class WebserviceHandler{
    
    
    /**
     Call webservice with required url,parameters,methodtype
     
     - parameter url:        api url to be hit
     - parameter methodType: method type of web service call
     - parameter parameters: parameters to hit url
     - parameter succeess:   action to be performed on success call of api
     - parameter failure:    action to be performed on failure call of api
     */
    func callWebService(url: String,methodType: String,
                        parameters: NSDictionary,
                        succeess: ((response: AnyObject?,headerFields:AnyObject?)->()),
                        failure: (error: NSData)->()) {
        
       if ( Reachability.isConnectedToNetwork()){
        showActivityIndicator()
        let param = parameters
        switch methodType {
        case WebServiceType.GET:
            Alamofire.request(.GET, url, parameters: param as? [String : AnyObject])
                .validate()
                .responseJSON { (response) in
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        LoadingActivityIndicatorView.hide()
                    })

                    if  (response.result.error != nil) {
                       self.showInvalidTokenError(response.result.error, requestURL: response.request!)
                        failure(error: response.data!)
                    } else {
                        if (response.response != nil) {
                        succeess(response: response.result.value,headerFields: response.response?.allHeaderFields)
                        }
                    }
            }
            break
        case WebServiceType.POST:
            Alamofire.request(.POST, url, parameters: param as? [String : AnyObject],encoding:.JSON)
                .validate()
                .responseJSON { (response) in
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        LoadingActivityIndicatorView.hide()
                    })
                    if  (response.result.error != nil) {
                       
                        self.showInvalidTokenError(response.result.error, requestURL: response.request!)
                        failure(error: response.data!)
                    } else {
                        if (response.response != nil) {
                        succeess(response: response.result.value,headerFields: response.response?.allHeaderFields)
                        }
                    }
            }
            break
        case WebServiceType.DELETE:
            Alamofire.request(.DELETE, url, parameters: param as? [String : AnyObject])
                .validate()
                .responseJSON { (response) in
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        LoadingActivityIndicatorView.hide()
                    })

                    if  (response.result.error != nil) {
                       self.showInvalidTokenError(response.result.error, requestURL: response.request!)
                        failure(error: response.data!)
                    } else {
                        if (response.response != nil) {
                        succeess(response: response.result.value,headerFields: response.response?.allHeaderFields)
                        }
                    }
            }
            break
            
        case WebServiceType.PUT:
            Alamofire.request(.PUT, url, parameters: param as? [String : AnyObject],encoding:.JSON)
                .validate()
                .responseJSON { (response) in
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        LoadingActivityIndicatorView.hide()
                    })
                    if  (response.result.error != nil) {
                       self.showInvalidTokenError(response.result.error, requestURL: response.request!)
                        failure(error: response.data!)
                    } else {
                        if (response.response != nil) {
                        succeess(response: response.result.value,headerFields: response.response?.allHeaderFields)
                        }
                    }
            }
            break
        default:
            break
        }
     }
       else{
               self.showNetworkError()
        }
    }
    
    
    /// this func is called when token is expired ,in that case navigate to login screen and remove token from user defaults
    func showInvalidTokenError(error: NSError?, requestURL:NSURLRequest) {
        if (error!.userInfo[ResponseParameters.STATUSCODE]! as? NSObject == ResponseParameters.NOT_FOUND) {
            if (requestURL.URL!.absoluteString != WebServiceUrls.LOGIN_URL()){
                 NavigationHandler().changeRootToLoginVC(true, islogOutClicked: false)
            }
        }
    }
    
    // when Internet is off ,show Internet Failure Toast
    func showNetworkError(){
        CommonHelper().showToastMessageOn(getCurrentWindow(), message:WebServiceErrors.INTERNET_FAILURE_MESSAGE)
    }
    
    /// Show activity Indicator
    func showActivityIndicator() {
        LoadingActivityIndicatorView.show(getCurrentWindow(), gifImage: ImageAssets.LOADER_GIF, size: CGSizeMake(LOADER_W_H,LOADER_W_H), animationDuration: 1.0, loadingText: "")
    }
    
    /// get current window to display activity Indicator
    func getCurrentWindow()->UIWindow{
       let currentMainWindow = UIApplication.sharedApplication().keyWindow
       return currentMainWindow!
    }

    /*
     Upload images in multipart along with other parameters
     */
    static func uploadImageAndData(url: String, methodType: String,
                            userImage:UIImage, email:String, mobile:String, dob: String, doa:String, id: Int,
                            succeess: ((response: AnyObject?,headerFields:AnyObject?)->()),
                            failure: (error: NSError)->()) {
        Reachability.internetCheckDependentCallWith {
            if url != GooglePlacesConstant.GOOGLE_BASE_URL {
                guard let currentMainWindow = UIApplication.sharedApplication().keyWindow else {
                    return
                }
                
                LoadingActivityIndicatorView.show(currentMainWindow, gifImage: Constant.ImageAsset.LOADER_GIF, size: CGSizeMake(LOADER_W_H,LOADER_W_H), animationDuration: 1.0, loadingText: "")
            }
        
        //paramter to be send for api call
        var parameter = [String:AnyObject]()
        parameter = [RequestParameters.AUTH_TOKEN: userLoginToken ,
        RequestParameters.EDIT_DOB: dob, RequestParameters.EDIT_ANNIVERSARY_DATE: doa,RequestParameters.EDIT_EMAIL: email, RequestParameters.EDIT_MOBILE_NUMBER: mobile]
        
        Alamofire.upload(.PUT, url, multipartFormData: {
            multipartFormData in
            if let imageData = UIImageJPEGRepresentation(userImage, CGFloat(NumberConstant.SIZE)) {
                
                multipartFormData.appendBodyPart(data: imageData, name: RequestParameters.EDIT_USER_IMAGE, fileName: StringUtilsConstant.FILE, mimeType: RequestParameters.IMAGE_PNG)
            }
            
            for (key, value) in parameter {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            }, encodingCompletion: {
                encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON {
                        response in
                        dispatch_async(dispatch_get_main_queue(),{
                            LoadingActivityIndicatorView.hide()
                        })
                        if (response.response != nil){
                            succeess(response: response.result.value,headerFields: response.response?.allHeaderFields)
                        }
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
      }
    }
    
    
    /// This method is used to notify server that  particular notification has been read
    ///
    /// - parameter notificationID: Notification ID From[FeedbackDetail,MembershipDetail,trial detail]
    func notifyServerNotificationViewed(notificationID: Int) {
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.ID: notificationID]
        self.callWebService(WebServiceUrls.NOTIFICATION_VIEWED(notificationID), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
            
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
}

