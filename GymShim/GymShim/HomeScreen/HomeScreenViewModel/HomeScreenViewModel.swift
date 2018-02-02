//
//  HomeScreenViewModel.swift
//  GymShim


import UIKit
import ObjectMapper

extension HomeScreenVC {
    //API Call for Change Password
    func getUserActiveMemberShips(){
        if (!userLoginToken.isEmpty) {
        let user = [RequestParameters.AUTH_TOKEN : userLoginToken,RequestParameters.IMAGE_SIZE:CommonHelper().getDeviceSizeForImage()]
        WebserviceHandler().callWebService(WebServiceUrls.USER_ACTIVE_MEMBERSHIPS(), methodType: WebServiceType.GET, parameters: user, succeess: {
            (response, headerFields) in
            self.mapResponseToModel(response)
        }, failure: { (error) in
                print("Error has \(error)")
        })
     }
    }
    
    /// Register user to receive notification
    /// Parameters: authToken
    func registerUserForNotification(authToken: String){
        if (!deviceToken.isEmpty){
            let notificationInfo = [RequestParameters.OS : StringUtilsConstant.OS, RequestParameters.REG_ID : deviceToken]
            let userInfo = [RequestParameters.NOTIFICATION : notificationInfo, RequestParameters.AUTH_TOKEN:userLoginToken]
            
            WebserviceHandler().callWebService(WebServiceUrls.USER_NOTIFICATION(), methodType: WebServiceType.POST, parameters: userInfo, succeess: {(response, headerFields) in
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

    
    /**
     Maps response to profile model
     
     - parameter response: response from api call which is to be mapped
     */
    func mapResponseToModel(response: AnyObject?) {
        homeScreenDataModel = Mapper<HomeScreenModel>().map(response)!
        (isMembershipOrTrialPresent()) ? reloadTableView() : showNoResultFound()
    }
    
    /// reloadTableView And Hide Error Label
    func reloadTableView(){
        lblShowErrorMessage.hidden = true
        tableViewActiveMemberships.reloadData()
        setNotificationBadgeCountInUserdefaults()
        checkForBadgeCount()
    }
    
    /// Add overlay to view
    func addOverLayToView(membershipNumber:String) {
        popQRCodeVC(membershipNumber)
        let frame = self.view.bounds
        self.overlay = UIView(frame: frame)
        self.overlay.alpha = 0.5
        self.overlay.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.overlay)
        self.view.bringSubviewToFront(self.overlay)
    }
    
    // remove overlay from view
    func removeOverLay() {
        self.overlay.removeFromSuperview()
    }
    
    /// add popOver controller
    func popQRCodeVC(memberShipID:String){
        let popController = UIStoryboard.mainStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.POP_OVER_QRCODE) as! PopOverQRVC
        popController.modalPresentationStyle = UIModalPresentationStyle.Popover
        // generating QRCode from String
        dispatch_async(dispatch_get_main_queue(),{
            popController.imageViewPopOverQRCode.image = CommonHelper().generateQRCodeForText(memberShipID)
        })
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = self.view
        popController.popoverPresentationController?.sourceRect = self.view.bounds
        self.presentViewController(popController, animated: true, completion: nil)
    }
    
    
    /// This function is used to check if membership/Trials are present oor nor
    ///
    /// - returns: boolean value depending upon condition
    func isMembershipOrTrialPresent() -> Bool {
        return (!homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails.isEmpty) || (!homeScreenDataModel.dictionaryTrialsAndMembership.gymTrialsArray.isEmpty) ? true : false
    }
    
    /// getGymName for the specified row
    func getGymName(indexPath:NSIndexPath)->String{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].gymName
    }
    
    /// get GymActivity for specified row
    func getGymActivity(indexPath:NSIndexPath)->String{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].planName
    }
    
    /// get Membership Start Date
    func getMembershipStartDate(indexPath:NSIndexPath)->String{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].membershipStartDate
    }
    
    /// get Membership End Date
    func getMembershipEndDate(indexPath:NSIndexPath)->String{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].membershipEndDate
    }
    
    /// get Total sessions of memberships
    func getTotalSessions(indexPath:NSIndexPath) -> Int{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].membershipTotalSessions
    }
    
    /// get Remianing session of memberships
    func getRemainingSessions(indexPath:NSIndexPath) -> Int{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].membershipRemainingSessions
    }
    
    /// get Day String from Model
    func getDayForSession(indexPath:NSIndexPath)->String{
        return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].dictionarySchedule!.sessionDay
    }
    
    /// get Time FOr Fym Session
    func getTimingForSession(indexPath:NSIndexPath)->String{
        return (homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].dictionarySchedule!.sessionTime.characters.count > 0) ?homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].dictionarySchedule!.sessionTime : StringUtilsConstant.NO_CLASS_TODAY
    }
    
    /// get membership to generate QRCode
    /// Parameters:- table index path
    /// return :- membership number
    func getMembershipNumberForQRCode(indexPath:NSIndexPath)->String{
        if (indexPath.section == HomeScreenTableCells.memberShipCell.rawValue) {
            return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].membershipNumber
        } else if (indexPath.section == HomeScreenTableCells.trialsCell.rawValue) {
           return homeScreenDataModel.dictionaryTrialsAndMembership.gymTrialsArray[indexPath.row].trialNumber
        }
        return StringUtilsConstant.EMPTY_STRING
    }
    
    /// get MemberShipID to pass for memberShipDetails API Call 
    func getMembershipID(indexPath:NSIndexPath)->String{
        return String(homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails[indexPath.row].membershipID)
    }
    
    /// get UserName
    func getUserName()->String{
        let Defaults = NSUserDefaults.standardUserDefaults()
        let userName = Defaults[UserDefaultConstants.USERNAME]
        return userName != nil ? userName as! String : ""
    }
    
    /// This function is used to add unread notification in userdefaults
    func setNotificationBadgeCountInUserdefaults() {
        notificationBadgeCount = homeScreenDataModel.dictionaryTrialsAndMembership.dictionaryUnreadCount.unreadCount
    }
    
    //show Error Message if no result Found
    func showNoResultFound() {
        lblShowErrorMessage.hidden = false
        lblShowErrorMessage.frame = CGRectMake(0,self.view.frame.size.height/2 - errorLableHeight, self.view.frame.size.width, CGFloat(ERROR_LABEL_HEIGHT))
        lblShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        lblShowErrorMessage.text = ValidationConstants.NO_ACTIVEMEMBERSHIP_OR_TRIALS
        lblShowErrorMessage.numberOfLines = ERROR_LABEL_LINES
        lblShowErrorMessage.textAlignment = .Center
        tableViewActiveMemberships .addSubview(lblShowErrorMessage)
    }
}
