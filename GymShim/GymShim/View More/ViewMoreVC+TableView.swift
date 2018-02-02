//
//  ViewMoreVC+TableView.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

extension ViewMoreVC {
    enum MoreTableCells: Int {
        case moreDetails = 0
        case pushNotificationSetting
    }
    
    //MARK:TableViewDelegate Delegate Method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberConstant.TWO
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case MoreTableCells.moreDetails.rawValue:
            return CGFloat(TableCellHeight.MORE_DETAILS_HEIGHT) + aboutGymExpandHeight
        case MoreTableCells.pushNotificationSetting.rawValue:
            return CGFloat(TableCellHeight.PN_SETTING_HEIGHT)
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case MoreTableCells.moreDetails.rawValue:
            return constructMoreDetailsTableCell(tableViewMore, indexPath: indexPath)
        case MoreTableCells.pushNotificationSetting.rawValue:
            return constructPushNotificationSettingTableCell(tableViewMore, indexPath: indexPath)
        default:
            return constructPushNotificationSettingTableCell(tableViewMore, indexPath: indexPath)
        }
    }
    
    /// Construct more details Cell That needs to be displayed on View more
    ///
    /// - parameter tableView: tableView on which cell is to be constructed
    /// - parameter indexPath: indeXpath of tableview
    ///
    /// - returns: constructed cell
    func constructMoreDetailsTableCell(tableView:UITableView, indexPath:NSIndexPath)->UITableViewCell{
        let moreDetailsTableCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.MORE_DETAILS_TABLE_CELL) as! MoreDetailsTableViewCell
        moreDetailsTableCell.viewMoreVC = self
        if (aboutGymExpandHeight == 0){
            moreDetailsTableCell.labelAboutGymNumberofLines = initialAboutGymShimNumberOfLines
            moreDetailsTableCell.tableViewMoreDetails.reloadData()
        }
        return moreDetailsTableCell
    }
    
    /// Construct push notification Cell That needs to be dispalyed on view more table
    ///
    /// - parameter tableView: tableView on which cell is to be constructed

    /// - parameter indexPath: indeXpath of tableview
    ///
    /// - returns: constructed cell
    func constructPushNotificationSettingTableCell(tableView:UITableView, indexPath:NSIndexPath)->UITableViewCell{
        let pNSettingTableCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.PN_SETTING_TABLE_CELL) as! PNSettingTableViewCell
        pNSettingTableCell.setDefaultStatus()
        pNSettingTableCell.switchPushNotificationOnOff.addTarget(self, action: #selector(switchPNSettingTapped), forControlEvents: .ValueChanged)
        return pNSettingTableCell
    }
    
    
    /// switch push notification tapped, calls alertview and on tap of yes calls webservice
    ///
    /// - parameter sender: switch which is clicked
    func switchPNSettingTapped(sender: UISwitch) {
        if sender.on {
            sender.tag = NumberConstant.ONE
            showAlertView(sender, title: AlertViewConstants.PN_ON_TITLE, message: AlertViewConstants.PN_ON_MESSAGE)
        } else {
            sender.tag = NumberConstant.TWO
            showAlertView(sender, title: AlertViewConstants.PN_OFF_TITLE, message: AlertViewConstants.PN_OFF_MESSAGE)
        }
    }
    
    
    /// creates alertview for notifying user to set push notification on or off
    ///
    /// - parameter sender:  switch that is triggered
    /// - parameter title:   title to be displayed on alertview
    /// - parameter message: message to be displayed on alertview
    func showAlertView(sender: UISwitch, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: AlertViewConstants.CANCEL, style: UIAlertActionStyle.Cancel, handler: {(ACTION :UIAlertAction!) in
            sender.tag == NumberConstant.ONE ? sender.setOn(false, animated: false) : sender.setOn(true, animated: false)
            alert.dismissViewControllerAnimated(true, completion: nil)
            }))
        alert.addAction(UIAlertAction(title: AlertViewConstants.OK, style: UIAlertActionStyle.Default, handler: {(ACTION :UIAlertAction!) in
            sender.tag == NumberConstant.ONE ? self.callPNOnWebService() : self.callPNOffWebService()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /// Calls web service for push notification on
    func callPNOnWebService() {
        viewMoreViewModel?.callWSPushNotificationSettingOn()
    }
    
    /// Calls web service for push notification ooff
    func callPNOffWebService() {
        viewMoreViewModel?.callWSPushNotificationSettingOff()
    }
}
