//
//  GymSchedule+TableView.swift
//  GymShim


import UIKit

extension GymScheduleVC {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGymScheduleInformation.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return scheduleCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       return constructScheduleTableCell(tableView, indexPath: indexPath)
    }
    
    func constructScheduleTableCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let scheduleCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.GYM_SCHEDULE_TABLE_CELL) as! GymScheduleTableCell
        scheduleCell.scheduleData = arrayGymScheduleInformation[indexPath.row]
        return scheduleCell
    }
    
}
