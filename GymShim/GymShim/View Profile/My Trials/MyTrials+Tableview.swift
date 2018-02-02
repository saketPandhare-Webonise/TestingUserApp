//
//  MyTrials+Tableview.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

extension MyTrialsVC {
    
    //MARK: Tableview datasource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return trialArrayCount()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(NumberConstant.TRIAL_CELL_HEIGHT)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return constructTrialCelL(tableView, indexPath: indexPath)
    }
    
    //MARK: Constructs cell
    /**
     Constructs trial cell with details of trials
     
     - parameter tableView: tableview on which cell is to be constructed
     
     - parameter indexPath: indexpath of that cell
     
     - returns: returns constructed cell with trial details
     */
    func constructTrialCelL(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell{
        let trialTableViewCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.TRIAL_TABLE_VIEW_CELL) as! TrialTableViewCell
        
        // set data in TableCell
        let gymTrials = sortedArrayMembership[indexPath.row]
        trialTableViewCell.gymTrials = gymTrials
        return trialTableViewCell
    }
}
