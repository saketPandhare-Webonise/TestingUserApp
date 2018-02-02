//
//  HomeScreen+TableView.swift
//  GymShim


import UIKit

extension HomeScreenVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableViewSectionCount
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // First Section is used to Display UserName,and second section is used to display membership data cell
        
        switch section {
        case HomeScreenTableCells.userNameCell.rawValue:
            return NUMBER_OF_USER_CELL
            
        case HomeScreenTableCells.memberShipCell.rawValue:
            return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails.count
            
        case HomeScreenTableCells.trialsCell.rawValue:
            return homeScreenDataModel.dictionaryTrialsAndMembership.gymTrialsArray.count
            
        default:
            return NUMBER_OF_USER_CELL
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case HomeScreenTableCells.userNameCell.rawValue:
            return userNameCellHeight
            
        case HomeScreenTableCells.memberShipCell.rawValue:
            return membershipCellHeight
            
        case HomeScreenTableCells.trialsCell.rawValue:
            return CGFloat(TableCellHeight.UPCOMING_TRIAL_HEIGHT)
            
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case HomeScreenTableCells.userNameCell.rawValue:
            return constructUserNameCell(tableView, indexPath: indexPath)
            
        case HomeScreenTableCells.memberShipCell.rawValue:
            return constructHomeMembershipCell(tableView, indexPath: indexPath)
            
        case HomeScreenTableCells.trialsCell.rawValue:
            return constructTrialCelL(tableView, indexPath: indexPath)
            
        default:
            return constructHomeMembershipCell(tableView, indexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!(homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails.isEmpty) && indexPath.section == HomeScreenTableCells.memberShipCell.rawValue) {
            NavigationHandler.navigateToScheduleScreen(navigationController!, membershipID: getMembershipID(indexPath))
        }
    }
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
            
        case HomeScreenTableCells.memberShipCell.rawValue , HomeScreenTableCells.trialsCell.rawValue:
            
            return createHeaderForSection(section)
            
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
            
        case HomeScreenTableCells.memberShipCell.rawValue:
            return homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails.count > NumberConstant.ZERO  ? SECTION_HEADER_HEIGHT_MEMEBRSHIP : MINIMUM_SECTION_HEADER_FOOTER_HEIGHT
            
        case HomeScreenTableCells.trialsCell.rawValue:
            return homeScreenDataModel.dictionaryTrialsAndMembership.gymTrialsArray.count > NumberConstant.ZERO ? SECTION_HEADER_HEIGHT_MEMEBRSHIP : MINIMUM_SECTION_HEADER_FOOTER_HEIGHT
            
        default:
            return MINIMUM_SECTION_HEADER_FOOTER_HEIGHT
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        switch section {
            
        case HomeScreenTableCells.trialsCell.rawValue :
            return FOOTER_HEIGHT_FOR_LAST_SECTION
            
        default:
            return MINIMUM_SECTION_HEADER_FOOTER_HEIGHT
        }
    }
    
    /// This function is used to construct Username cell
    /// - parameter tableView: tableViewActiveMemberships
    /// - parameter indexPath: IndexPath
    /// - returns: TableCell
    func constructUserNameCell(tableView: UITableView,indexPath: NSIndexPath)->UITableViewCell{
        let userNameCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.USERNAME_CELL) as! UserNameCell
        userNameCell.labelUserName.text = StringUtilsConstant.WELCOME + getUserName() + StringUtilsConstant.COMMA
        userNameCell.buttonExpandQRCode.addTarget(self, action: #selector(enlargeUserQRCode(_:)), forControlEvents: .TouchUpInside)
        return userNameCell
    }
    
    /// This function is used to construct Membership Cell
    /// - parameter tableView: tableViewActiveMemberships
    /// - parameter indexPath: IndexPath
    ///
    /// - returns: TableCell
    func constructHomeMembershipCell(tableView: UITableView,indexPath:NSIndexPath)->UITableViewCell{
        
        let homeMemberShipCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.HOME_MEMBERSHIP_CELL) as! HomeMembershipCell
        
        //QR-Code Generation Goes Here ,needs to be implemented
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.qrCodeImage = CommonHelper().generateQRCodeForText(self.getMembershipNumberForQRCode(indexPath))
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                homeMemberShipCell.imageViewQRCode.image = self.qrCodeImage
            }
        }
        homeMemberShipCell.buttonQRCode.addTarget(self, action: #selector(navigateToEnlargeQRCode(_:)), forControlEvents: .TouchUpInside)
        homeMemberShipCell.buttonQRCode.tag = (indexPath.section * MULTYPING_CONSTANT_INDEXPATH) + indexPath.row
        homeMemberShipCell.labelGymName.text = getGymName(indexPath)
        homeMemberShipCell.labelGymActivity.text = getGymActivity(indexPath)
        homeMemberShipCell.labelStartDate.text = getMembershipStartDate(indexPath)
        homeMemberShipCell.labelEndDate.text = getMembershipEndDate(indexPath)
        homeMemberShipCell.labelTotalSessions.text = appendZeroForSingularValue(getTotalSessions(indexPath)) + getTitleSession(getTotalSessions(indexPath))
        homeMemberShipCell.labelRemainingSesisons.text = appendZeroForSingularValue(getRemainingSessions(indexPath)) + getTitleSession(getRemainingSessions(indexPath))
        homeMemberShipCell.labelToday.text = getDayForSession(indexPath)
        homeMemberShipCell.labelTodayTime.text = getTimingForSession(indexPath)
        
        return homeMemberShipCell
    }
    
    /**
     On click of QR code navigate to enlarge QR code screen
     */
    func navigateToEnlargeQRCode(sender: UIButton) {
        let enlargeQRVC = UIStoryboard.mainStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.ENLARGE_QR_VC) as! EnlargeQRVC
        let section = sender.tag / MULTYPING_CONSTANT_INDEXPATH
        let row = sender.tag % MULTYPING_CONSTANT_INDEXPATH
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        enlargeQRVC.membershipNumber = getMembershipNumberForQRCode(indexPath)
        navigationController?.pushViewController(enlargeQRVC, animated: false)
    }
    
    /**
     Constructs trial cell with details of trials
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - parameter indexPath: indexpath of that cell
     
     - returns: returns constructed cell with trial details
     */
    func constructTrialCelL(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell{
        if let trialTableViewCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.UPCOMING_TRAIL_TABLE_CELL) as? UpcomingTrialCell{
            
            // set data in TableCell
            let gymTrials = homeScreenDataModel.dictionaryTrialsAndMembership.gymTrialsArray[indexPath.row]
            trialTableViewCell.gymTrials = gymTrials
            
            //QR-Code Generation Goes Here ,needs to be implemented
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.qrCodeImage = CommonHelper().generateQRCodeForText(gymTrials.trialNumber)
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    trialTableViewCell.imageViewQRCode.image = self.qrCodeImage
                }
            }
            trialTableViewCell.buttonQRCode.tag = (indexPath.section * MULTYPING_CONSTANT_INDEXPATH) + indexPath.row
            trialTableViewCell.buttonQRCode.addTarget(self, action: #selector(navigateToEnlargeQRCode(_:)), forControlEvents: .TouchUpInside)
            
            return trialTableViewCell
        }
        return UpcomingTrialCell()
    }
    
    /// Creates Header for My Memberships and trials.
    ///
    /// - Parameter section: section of the collection view tapped.
    /// - Returns: Returns section header if data is present.
    
    func createHeaderForSection(section : Int)-> UIView?{
        
        if (section == HomeScreenTableCells.memberShipCell.rawValue ? homeScreenDataModel.dictionaryTrialsAndMembership.membershipDetails.count : homeScreenDataModel.dictionaryTrialsAndMembership.gymTrialsArray.count) > Constant.NumberConstants.ZERO {
            
            if let arrayOfNibs = NSBundle.mainBundle().loadNibNamed(Constant.NibIdentefiers.HOME_SECTION_HEADER, owner: self, options: nil){
                let sectionHeaderView = arrayOfNibs[Constant.NumberConstants.ZERO]  as? HomeSectionHeader
                sectionHeaderView?.title = section == HomeScreenTableCells.memberShipCell.rawValue ? HEADER_TITLE_ACTIVE_MEMBERSHIPS : HEADER_TITLE_TRIALS
                return sectionHeaderView
            }
            
            return UIView()
        }
        return nil
    }
    
    /// This function is used to enlarge User QRCode
    /// -Parameter:- Button
    func enlargeUserQRCode(sender: UIButton) {
        let enlargeQRVC = UIStoryboard.mainStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.ENLARGE_QR_VC) as! EnlargeQRVC
        enlargeQRVC.membershipNumber = userID
        navigationController?.pushViewController(enlargeQRVC, animated: false)
    }
}
