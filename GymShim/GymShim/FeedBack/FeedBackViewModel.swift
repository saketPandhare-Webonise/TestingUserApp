//
//  FeedBackViewModel.swift
//  GymShim


import UIKit
import ObjectMapper

protocol FeedBackListingApiDelegate {
    func onSuccess()
    func onFailure(error:String)
}

class FeedBackViewModel: NSObject {
    
    var feedBackModel: FeedBackModel = FeedBackModel()
    var userSingleFeedBackModel: UserSingleFeedBack = UserSingleFeedBack()
    var feedBackApiDelegate: FeedBackListingApiDelegate?
    var arrayFeedBacks = [FeedBackList]()
    var feedBackListArray = NSMutableArray()
    var feedBackListSet =  NSMutableOrderedSet()
    var perPage:Int = 10
    var pageNo:Int = 1
    /// This function is used to Get FeedBacks given by user
    func getUserFeedBacks() {
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.PAGE: getPageNo(),RequestParameters.PER_PAGE: perPage,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage()]
        
        WebserviceHandler().callWebService(WebServiceUrls.USER_FEEDBACK(), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
            self.mapResponseToModel(response)
            self.feedBackApiDelegate?.onSuccess()
            }, failure: { (error) in
                print("Error has \(error)")
        })
     }
    }
    
    /**
     Maps response to profile model
     
     - parameter response: response from api call which is to be mapped
     */
    func mapResponseToModel(response: AnyObject?) {
        self.feedBackModel = Mapper<FeedBackModel>().map(response)!
        appendFeedbackObjecttoArray()
    }
    
    /// Get Page no that needs to be send to Webservice as parameter
    ///
    /// - returns: page no count
    func getPageNo()->Int {
        return pageNo
    }
    
    /// Increment Page no for Pagination
    func incrementPageNo() {
        pageNo += 1
    }
    
    /// This function returns array count of feedbacks received from Webservice
    ///
    /// - returns: count
    func getTotalNumberOfSection()->Int {
        return feedBackListSet.count
    }
    
    /// Add Feedback List Object to array after Webservice call
    func appendFeedbackObjecttoArray() {
        for i in 0..<self.feedBackModel.arrayFeedBacks.count  {
            feedBackListSet.addObject(self.feedBackModel.arrayFeedBacks[i])
        }
    }
    
    /// This method returns single object of feedbackListArray
    ///
    /// - parameter indexPath: tableIndexPath
    ///
    /// - returns: feedback List object
    func getFeedBackObjectFromArray(indexPath:NSIndexPath)->FeedBackList{
        return feedBackListSet.objectAtIndex(indexPath.row) as! FeedBackList
    }
    
    /// Get count of total number of FeedBack Present
    ///
    /// - returns: count of total feedback
    func getMaximumFeedBackPresent()->Int{
        return self.feedBackModel.dictionaryFeedBackCount.totalFeedBack
    }
    
    /// Add user Submitted Post At the 0 index to show at top
    ///
    /// - parameter response: response from server
    func mapSinglePostToModel(response: AnyObject?){
        self.userSingleFeedBackModel = Mapper<UserSingleFeedBack>().map(response)!
        feedBackListSet.insertObject(self.userSingleFeedBackModel.dictionaryUserFeedBack, atIndex: 0)
    }
}
