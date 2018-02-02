//
//  ScheduleTableCell.swift
//  GymShim


import UIKit

class ScheduleTableCell: UITableViewCell {

    @IBOutlet weak var labelMembershipDay: UILabel!
    @IBOutlet weak var labelMembershipTime: UILabel!
    var scheduleDetails = MembershipTiming() {
        didSet {
            setScheduleForGym()
        }
    }
    //TO-DO
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// This function is used to display schedule in membership Details screen 
    func setScheduleForGym() {
        labelMembershipDay.text = scheduleDetails.day
        labelMembershipTime.text = scheduleDetails.time
    }

    
}
