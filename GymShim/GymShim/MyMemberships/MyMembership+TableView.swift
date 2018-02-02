//
//  MyMembership+TableView.swift
//  GymShim

import UIKit

extension MyMembershipVC {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membershipArrayCount()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return membershipCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return constructMembershipCell(tableView, indexPath: indexPath)
    }
    
    /// construct MemberShipCell
    func constructMembershipCell(tableView: UITableView,indexPath: NSIndexPath)->UITableViewCell{
        // TODO: Will be chaged once API gets integrate
        let memberShipCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.MEMBERSHIPCELL) as! MembershipCell
        
        /// set data in TableCell
        let gymMembership = sortedArrayMembership[indexPath.row]
        memberShipCell.gymMembership = gymMembership
        return memberShipCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NavigationHandler.navigateToScheduleScreen(navigationController!, membershipID: String(sortedArrayMembership[indexPath.row].memberShipID))
    }
}
