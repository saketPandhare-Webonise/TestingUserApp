//
//  ViewProfileVC+TableView.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions
import SDWebImage

extension ViewProfileVC: UITableViewDelegate, UITableViewDataSource {
    enum ProfileTableCells : Int {
        case userDetails = 0
        case myMembership
        case myTrials
        case changePassword
        case logout
    }
    
    //MARK: Tableview datasource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberConstant.FIVE
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case ProfileTableCells.userDetails.rawValue:
            return UITableViewAutomaticDimension
        case ProfileTableCells.myMembership.rawValue:
            return arrayGymMembership.count == NumberConstant.ZERO ?  CGFloat(NumberConstant.ZERO) : UITableViewAutomaticDimension
        case ProfileTableCells.myTrials.rawValue:
            return arrayGymTrials.count == NumberConstant.ZERO ?  CGFloat(NumberConstant.ZERO) : UITableViewAutomaticDimension
        case ProfileTableCells.changePassword.rawValue:
            return UITableViewAutomaticDimension
        case ProfileTableCells.logout.rawValue:
            return UITableViewAutomaticDimension
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ProfileTableCells.userDetails.rawValue:
            return self.constructUserDetailsCell(tableView)
        case ProfileTableCells.myMembership.rawValue:
            return self.constructMyMembershipCell(tableView)
        case ProfileTableCells.myTrials.rawValue:
            return self.constructMyTrialsCell(tableView)
        case ProfileTableCells.changePassword.rawValue:
            return self.constructChangePasswordCell(tableView)
        case ProfileTableCells.logout.rawValue:
            return self.constructLogoutCell(tableView)
        default:
            return self.constructLogoutCell(tableView)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == ProfileTableCells.changePassword.rawValue {
            let changePassword = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.CHANGEPASSWORD) as! ChangePasswordVC
            changePassword.fromLogin = false
            changePassword.passwordChangedSuccessfullyDelegate = self
            pushVC(changePassword)
        }
        if indexPath.row == ProfileTableCells.logout.rawValue {
            viewProfileViewModel?.logoutUser()
        }
        if indexPath.row == ProfileTableCells.myMembership.rawValue {
            NavigationHandler.navigateToScheduleScreen(navigationController!, membershipID: String(arrayGymMembership[0].memberShipID))
        }
    }
    
    //MARK: Constructs tableview cells
    /**
     Constructs user details cell
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - returns: returns constructed cell showing user details
     */
    func constructUserDetailsCell(tableView: UITableView) -> UserDetailsTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.USER_DETAILS_TABLE_VIEW_CELL) as! UserDetailsTableViewCell
        cell.userDetails = userDetails
        if isEditCalled && cell.imageViewAvatar.image != ImageAssets.USERDEFAULT_IMAGE {
            SDImageCache.sharedImageCache().removeImageForKey(self.userDetails.avatar)
            isEditCalled = false
        }
        ImageUtility.setAsyncImage(cell.imageViewAvatar, imageUrl: userDetails.avatar!, defaultImageName: ImageAssets.USERDEFAULT_IMAGE, completionBlock: nil)
        cell.buttonEditProfile.addTarget(self, action: #selector(buttonEditProfileClicked), forControlEvents: .TouchUpInside)
        cell.buttonBirthDate.addTarget(self, action: #selector(buttonEditProfileClicked), forControlEvents: .TouchUpInside)
        cell.buttonAnniversaryDate.addTarget(self, action: #selector(buttonEditProfileClicked), forControlEvents: .TouchUpInside)
        return cell
    }
    
    /**
     Constructs my membership cell
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - returns: returns constructed cell with my membership
     */
    func constructMyMembershipCell(tableView: UITableView) -> MyMembershipsTableViewCell {
        if arrayGymMembership.count > NumberConstant.ZERO {
            let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.MEMBERSHIP_TABLE_VIEW_CELL) as! MyMembershipsTableViewCell
            cell.count = arrayGymMembership.count
            selectMembershipToBeDisplayed(cell)
            cell.buttonViewAll.addTarget(self, action: #selector(viewAllMembershipsClicked), forControlEvents: .TouchUpInside)
            return cell
        }
        return MyMembershipsTableViewCell()
    }
    
    /**
     Constructs my trials cell
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - returns: returns constructed cell with my membership
     */
    func constructMyTrialsCell(tableView: UITableView) -> MyTrialsTableViewCell {
        if arrayGymTrials.count > NumberConstant.ZERO {
            let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.MY_TRIALS_VIEW_CELL)
                as! MyTrialsTableViewCell
            cell.count = arrayGymTrials.count
            selectTrialToBeDisplayed(cell)
            cell.buttonViewAllTrials.addTarget(self, action: #selector(viewAllTrialsClicked), forControlEvents: .TouchUpInside)
            return cell
        }
        return MyTrialsTableViewCell()
    }
    
    /**
     Constructs change password cell
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - returns: returns constructed cell with change password functionality
     */
    func constructChangePasswordCell(tableView: UITableView) -> LogoutTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.LOGOUT_TABLE_VIEW_CELL) as! LogoutTableViewCell
        cell.labelLogout.text = StringUtilsConstant.CHANGE_PASSWORD
        cell.imageViewLogOut.image = UIImage(named:ImageAssets.RIGHT_ARROW_ICON)
        return cell
    }
    
    /**
     Constructs logout cell
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - returns: returns constructed cell with logout functionality
     */
    func constructLogoutCell(tableView: UITableView) -> LogoutTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.LOGOUT_TABLE_VIEW_CELL) as! LogoutTableViewCell
        cell.imageViewLogOut.image = UIImage(named:ImageAssets.LOGOUT_IMAGE)
        return cell
    }
    
    /**
     edit profile button clicked
     
     - parameter sender: button
     */
    func buttonEditProfileClicked(sender: UIButton!) {
        let editProfileVC = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.EDIT_PROFILE_VC)
            as! EditProfileVC
        editProfileVC.userDetails = UserDetails()
        editProfileVC.userDetails = self.userDetails
        editProfileVC.fromEditProfile = true
        editProfileVC.editApiCallDelegate = self
        pushVC(editProfileVC)
    }
    
    /**
     Get Gym membership index according to its status
     
     - parameter status: status can be active, past or upcoming
     */
    func getGymMembership(status: String) -> Int {
        for index in NumberConstant.ZERO..<arrayGymMembership.count {
            if ( self.arrayGymMembership[index].memberShipStatus.lowercaseString == status) {
                return index
            }
        }
        return NumberConstant.DOES_NOT_EXIST
    }
    
    /**
     Navigates to my membership view controller
     */
    func viewAllMembershipsClicked() {
        let storyboard = UIStoryboard.mainStoryboard
        let memberShipVC = storyboard!.instantiateVC(MyMembershipVC)
        memberShipVC?.arrayMyMembership = arrayGymMembership
        pushVC(memberShipVC!)
    }
    
    /**
     selects membership cell as per the status,it checks for active, upcoming and past
     
     - parameter cell: as per the selection sets the propeties of cell
     */
    func selectMembershipToBeDisplayed(cell: MyMembershipsTableViewCell) {
        if getGymMembership(StringUtilsConstant.ACTIVE) != NumberConstant.DOES_NOT_EXIST {
            cell.gymMembership = (viewProfileViewModel?.userProfileModel.user.arrayMyMembership[getGymMembership(StringUtilsConstant.ACTIVE)])!
        } else if getGymMembership(StringUtilsConstant.UPCOMING) != NumberConstant.DOES_NOT_EXIST {
            cell.gymMembership = (viewProfileViewModel?.userProfileModel.user.arrayMyMembership[getGymMembership(StringUtilsConstant.UPCOMING)])!
        } else if getGymMembership(StringUtilsConstant.PAST) != NumberConstant.DOES_NOT_EXIST {
            cell.gymMembership = (viewProfileViewModel?.userProfileModel.user.arrayMyMembership[getGymMembership(StringUtilsConstant.PAST)])!
        }
    }
    
    /**
     Navigates to my trials view controller
     */
    func viewAllTrialsClicked() {
        let storyboard = UIStoryboard.mainStoryboard
        let myTrialsVC = storyboard!.instantiateVC(MyTrialsVC)
        myTrialsVC?.arrayMyTrials = arrayGymTrials
        pushVC(myTrialsVC!)
    }
    
    /**
     Get Gym trial index according to its status
     
     - parameter status: status can be past or upcoming
     */
    func getGymTrials(status: String) -> Int {
        for index in NumberConstant.ZERO..<arrayGymTrials.count {
            if ( self.arrayGymTrials[index].memberShipStatus.lowercaseString == status) {
                return index
            }
        }
        return NumberConstant.DOES_NOT_EXIST
    }
    
    /**
     selects trial cell as per the status,it checks for  upcoming and past
     
     - parameter cell: as per the selection sets the propeties of cell
     */
    func selectTrialToBeDisplayed(cell: MyTrialsTableViewCell) {
        if getGymTrials(StringUtilsConstant.UPCOMING) != NumberConstant.DOES_NOT_EXIST {
            cell.gymTrials = arrayGymTrials[getGymTrials(StringUtilsConstant.UPCOMING)]
        } else if getGymTrials(StringUtilsConstant.PAST) != NumberConstant.DOES_NOT_EXIST {
            cell.gymTrials = arrayGymTrials[getGymTrials(StringUtilsConstant.PAST)]
        }
    }
    
}
