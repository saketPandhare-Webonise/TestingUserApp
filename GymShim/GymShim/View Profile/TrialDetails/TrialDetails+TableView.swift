//
//  TrialDetails+TableView.swift
//  GymShim


import UIKit

extension TrialDetailsVC {
    
    //MARK: Tableview datasource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        //        // set data in TableCell
        let gymTrials = trialDetailViewModel.userSingleTrialModel.dictionaryUserTrial
        trialTableViewCell.gymTrials = gymTrials
        return trialTableViewCell
    }
    
}
