//
//  PostFeedBack+TableView.swift
//  GymShim


import UIKit

extension PostFeedBackVC {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO:
        return postFeedBackViewModel.getGymArrayCount()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return gymNameCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return constructMembershipCell(tableView, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       textViewGymName.text = postFeedBackViewModel.getGymName(indexPath.row)
       selectedGymID = postFeedBackViewModel.getGymID(indexPath.row)
       toggleTableViewAndButtonImage()
       isGymSelected = true
    }
    
    /// construct MemberShipCell
    func constructMembershipCell(tableView: UITableView,indexPath: NSIndexPath)->UITableViewCell{
        // TODO: Will be chaged once API gets integrate
        let gymNameTableCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.GYM_NAME_TABLE_CELL) as! GymNameTableCell
        gymNameTableCell.memberShipDetails = postFeedBackViewModel.getGymListArray(indexPath.row)
        return gymNameTableCell
    }
}
