//
//  MyMembershipViewModel.swift
//  GymShim


import UIKit

extension MyMembershipVC {
    
    
    /// Sort Data according to the button clicked [Upcoming.Active,Past]
    ///
    /// - returns: count of sorted data
    func membershipArrayCount()->Int{
        
        rowCount = 0
        sortedArrayMembership = []
        for i in 0...arrayMyMembership.count - 1 {
            if (upcomingTabCliced){
                if ( self.arrayMyMembership[i].memberShipStatus.lowercaseString == upComingTab) {
                    self.filterMembershipData(i)
                }
            }
            if (activityTabClicked){
                if ( self.arrayMyMembership[i].memberShipStatus.lowercaseString == activeTab) {
                    self.filterMembershipData(i)
                }
            }
            if (pastTabClicked){
                if ( self.arrayMyMembership[i].memberShipStatus.lowercaseString == pastTab) {
                    self.filterMembershipData(i)
                }
            }
        }
        ///if total rows are zero then display error message
        (rowCount == 0) ? showNoResultFound() : hideErrorLabel()
        return rowCount
    }
    
    
    /// Filter Data According to Selectede Button
    ///
    /// - parameter i: array index
    func filterMembershipData(i:Int){
        rowCount = rowCount + 1
        sortedArrayMembership.append(self.arrayMyMembership[i])
    }
    
    
    /// Display error message if no activity found for particular tab
    func showNoResultFound() {
        lblShowErrorMessage.hidden = false
        lblShowErrorMessage.frame = CGRectMake(0,self.view.frame.size.height/2 - CGFloat(UIButtonConstants.UPCOMING_ACTIVE_PAST), self.view.frame.size.width, CGFloat(FontSize.TWENTYONE))
        lblShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        lblShowErrorMessage.text = getErrorMessageForSelectedTab()
        lblShowErrorMessage.numberOfLines = 2
        lblShowErrorMessage.textAlignment = .Center
        tableViewMyMemberships .addSubview(lblShowErrorMessage)
    }
    
    /// Hide error label displayed when memberships are present
    func hideErrorLabel() {
        lblShowErrorMessage.hidden = true
    }
    
    
    /// Get error message to be displayed for selected tab ,if no activity is present for it
    ///
    /// - returns: string containing error message
    func getErrorMessageForSelectedTab()->String{
        
        switch true {
            case upcomingTabCliced:
            return ValidationConstants.NO_UPCOMING_MEMBERSHIP
            
            case activityTabClicked:
            return ValidationConstants.NO_ACTIVEMEMBERSHIP_FOUND
            
            case pastTabClicked:
            return ValidationConstants.NO_PAST_MEMBERSHIP
            
            default:
            return ValidationConstants.NO_PAST_MEMBERSHIP
        }
    }

}
