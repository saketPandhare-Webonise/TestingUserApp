//
//  MembershipCell.swift
//  GymShim

import UIKit

class MembershipCell: UITableViewCell {
    @IBOutlet weak var labelGymName: UILabel!
    @IBOutlet weak var labelGymActivity: UILabel!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelTotalSessions: UILabel!
    @IBOutlet weak var labelRemainingSessions: UILabel!
    
    var indexPath = NSIndexPath()
    var gymMembership = GymMembership() {
        didSet {
           setMemberShipData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Set data in cell
    func setMemberShipData() {
       labelGymName.text =  gymMembership.gymName
       labelGymActivity.text =  gymMembership.membershipActivity.planName
       labelStartDate.text = gymMembership.memberShipStartDate
       labelEndDate.text = gymMembership.memberShipEndDate
       labelTotalSessions.text = gymMembership.memberShipSessions == NumberConstant.ONE ? String(gymMembership.memberShipSessions) + StringUtilsConstant.SESSION : String(gymMembership.memberShipSessions) + StringUtilsConstant.SESSIONS
       labelRemainingSessions.text = gymMembership.memberShipRemainingSessions == NumberConstant.ONE ? String(gymMembership.memberShipRemainingSessions) + StringUtilsConstant.SESSION : String(gymMembership.memberShipRemainingSessions) + StringUtilsConstant.SESSIONS
    }
}
