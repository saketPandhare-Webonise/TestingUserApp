//
//  PostFeedBackViewModel.swift
//  GymShim
//


import UIKit
import  EZSwiftExtensions
import ObjectMapper

protocol GymNamePostFeedBackDelegate {
    func onSuccess()
    func onFailure(error:String)
}
protocol FeedBackPostedDelegate {
    func feedBackPostedSuccessfully(response:AnyObject)
    func errorPostingFeedBack()
}

class PostFeedBackViewModel: NSObject {
    var postFeedBackModel: PostFeedBackModel = PostFeedBackModel()
    var gymNamePostFeedBackDelegate: GymNamePostFeedBackDelegate?
    var feedBackPostedDelegate: FeedBackPostedDelegate?
    
    /**
     WebService call to get list of gyms subscribed Gyms
     */
    func getSubscribedGymListForUser() {
        if (!userLoginToken.isEmpty) {
        let requestParameters = [RequestParameters.AUTH_TOKEN : userLoginToken]
        WebserviceHandler().callWebService(WebServiceUrls.GYMLIST_FOR_FEEDBACK(), methodType: WebServiceType.GET, parameters: requestParameters, succeess: {
            (response, headerFields) in
            self.mapResponseToModel(response)
            self.gymNamePostFeedBackDelegate?.onSuccess()
            
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
    
    /**
     parse response to model after we get response from webservice
     */
    func mapResponseToModel(response: AnyObject?) {
        self.postFeedBackModel = Mapper<PostFeedBackModel>().map(response)!
    }
    
    /**
     This func will return array count for the gyms user has subscribed for
     */
    func getGymArrayCount()->Int {
        return self.postFeedBackModel.arrayGymList.count
    }
    
    /**
     This func will return gymList array
     */
    func getGymListArray(rowNo:Int)->ListGyms {
        return self.postFeedBackModel.arrayGymList[rowNo]
    }
    
    /**
     This func will return gymName for the row no provided
     */
    func getGymName(rowNo:Int) -> String {
        return self.postFeedBackModel.arrayGymList[rowNo].gymName
    }
    
    /**
     This func will return gymID for the row no provided
     */
    func getGymID(rowNo:Int) -> Int {
        return self.postFeedBackModel.arrayGymList[rowNo].gymID
    }
    
    /**
     This func will return gymslug for the row no provide
     */
    func getGymSlug(rowNo:Int) -> String {
        return self.postFeedBackModel.arrayGymList[rowNo].gymSlug
    }
    
    /**
     Webservice call To Post feedback request para,gymID,Subject and user written feedback
     */
    func callWebserviceForPostingFeedBack(gymId: Int, subject: String, feedBack: String) {
        if (!userLoginToken.isEmpty) {
        let dictionaryFeedback = NSMutableDictionary()
        dictionaryFeedback.setValue(gymId, forKey: RequestParameters.FEEDBACK_GYM_ID)
        dictionaryFeedback.setValue(subject, forKey: RequestParameters.FEEDBACK_TITLE)
        dictionaryFeedback.setValue(feedBack, forKey: RequestParameters.FEEDBACK_COMMENT)
        let postFeedBackRequestParameters = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.FEED_BACK:dictionaryFeedback,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage()]
        
        WebserviceHandler().callWebService(WebServiceUrls.USER_FEEDBACK(), methodType: WebServiceType.POST, parameters: postFeedBackRequestParameters, succeess: {
            (response, headerFields) in
            self.feedBackPostedDelegate?.feedBackPostedSuccessfully(response!)
            }, failure: { (error) in
                print("Error has \(error)")
        })
      }
    }
}
