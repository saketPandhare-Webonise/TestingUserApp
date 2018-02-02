//
//  MyTrialsViewModel.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions
import ObjectMapper

extension MyTrialsVC {
    /**
     Sort Data according to the button clicked [Upcoming,Past]
     
     - returns: count of sorted data
     */
    func trialArrayCount() -> Int {
        rowCount = NumberConstant.ZERO
        sortedArrayMembership.removeAll()
        for i in NumberConstant.ZERO..<arrayMyTrials.count {
            if (isUpcomingTapped){
                if ( self.arrayMyTrials[i].memberShipStatus.lowercaseString == upComingTab) {
                    self.filterMembershipData(i)
                }
            }
            if (isPastTapped){
                if ( self.arrayMyTrials[i].memberShipStatus.lowercaseString == pastTab) {
                    self.filterMembershipData(i)
                }
            }
        }
        
        //if total rows are zero then display error message
        (rowCount == NumberConstant.ZERO) ? showNoResultFound() : hideErrorLabel()
        return rowCount
    }
    
    /**
     Filter Data According to Selectede Button
     
     - parameter index: array index
     */
    func filterMembershipData(index: Int) {
        rowCount = rowCount + NumberConstant.ONE
        sortedArrayMembership.append(self.arrayMyTrials[index])
    }
    
    /**
     Display error message if no activity found for particular tab
     */
    func showNoResultFound() {
        labelShowErrorMessage.hidden = false
        labelShowErrorMessage.frame = CGRectMake(CGFloat(NumberConstant.ZERO), self.view.frame.size.height/2 - CGFloat(UIButtonConstants.UPCOMING_ACTIVE_PAST),
                                                 self.view.frame.size.width, CGFloat(FontSize.TWENTYONE))
        labelShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        labelShowErrorMessage.text = getErrorMessageForSelectedTab()
        labelShowErrorMessage.numberOfLines = NumberConstant.TWO
        labelShowErrorMessage.textAlignment = .Center
        tableViewMyTrials .addSubview(labelShowErrorMessage)
    }
    
    /**
     Hide error label displayed when memberships are present
     */
    func hideErrorLabel() {
        labelShowErrorMessage.hidden = true
    }
    
    /**
     Get error message to be displayed for selected tab ,if no activity is present for it
     
     - returns: string containing error message
     */
    func getErrorMessageForSelectedTab() -> String {
        if isUpcomingTapped {
            return ValidationConstants.NO_UPCOMING_TRIALS
        }
        return ValidationConstants.NO_PAST_TRIALS
    }
    
    
    func getUserNotifiedTrial(trialID: Int){
        if (!userLoginToken.isEmpty) {
        let userFeedBackRequestPara = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage(),RequestParameters.ID: trialID]
        WebserviceHandler().callWebService(WebServiceUrls.GET_FEEDBACK_DETAIL(trialID), methodType: WebServiceType.GET, parameters: userFeedBackRequestPara, succeess: {
            (response, headerFields) in
            self.mapSinglePostToModel(response)
            self.reloadTrialTableView()
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
       // self.userSingleTrialModel = Mapper<UserSingleTrial>().map(response)!
    }
    
    
    /// Insert Data to Array and reload table View 
    func reloadTrialTableView() {
//        self.sortedArrayMembership.insert( self.userSingleTrialModel.dictionaryUserTrial, atIndex: 0)
//        tableViewMyTrials.reloadData()
    }
}
