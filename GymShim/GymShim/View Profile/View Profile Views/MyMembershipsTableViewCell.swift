//
//  MyMembershipsTableViewCell.swift
//  GymShim
//

import UIKit

class MyMembershipsTableViewCell: UITableViewCell {
    @IBOutlet var labelMyMembershipHeader: UILabel!
    @IBOutlet var labelGymName: UILabel!
    @IBOutlet var labelGymPlan: UILabel!
    @IBOutlet var labelStartDate: UILabel!
    @IBOutlet var labelEndDate: UILabel!
    @IBOutlet var labelTotalSessions: UILabel!
    @IBOutlet var labelRemainingSessions: UILabel!
    @IBOutlet var viewMembershipDetails: UIView!
    @IBOutlet var buttonViewAll: UIButton!
    @IBOutlet var constraintViewAllHeight: NSLayoutConstraint!
    @IBOutlet var imageViewArrow: UIImageView!
    @IBOutlet var viewAll: UIView!
    @IBOutlet var labelViewAll: UILabel!
    @IBOutlet var viewHorizontalBar: UIView!
    
    var count:Int = 0
    var gymMembership = GymMembership() {
        didSet {
            uiSetup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CommonHelper.addShadowToView(viewMembershipDetails)
    }
    
    /**
     UI setup method to set membership details
     */
    func uiSetup() {
        //checks the count of memberships, if it is one then sets title as membership else membership
        labelMyMembershipHeader.text = count == NumberConstant.ONE ? StringUtilsConstant.MY_MEMBERSHIPS + StringUtilsConstant.OPENING_BRACKETS + String(format: StringUtilsConstant.TWO_DIGIT_FORMAT, count) + StringUtilsConstant.CLOSING_BRACKETS : StringUtilsConstant.MY_MEMBERSHIPS + StringUtilsConstant.OPENING_BRACKETS + String(format: StringUtilsConstant.TWO_DIGIT_FORMAT, count) + StringUtilsConstant.CLOSING_BRACKETS

        labelGymName.text =  gymMembership.gymName
        labelGymPlan.text =  gymMembership.membershipActivity.planName
        labelStartDate.text = gymMembership.memberShipStartDate
        labelEndDate.text = gymMembership.memberShipEndDate
        labelTotalSessions.text = gymMembership.memberShipSessions == NumberConstant.ONE ? String(gymMembership.memberShipSessions) + StringUtilsConstant.SESSION : String(gymMembership.memberShipSessions) + StringUtilsConstant.SESSIONS
        labelRemainingSessions.text = gymMembership.memberShipRemainingSessions == NumberConstant.ONE ? String(gymMembership.memberShipRemainingSessions) + StringUtilsConstant.SESSION : String(gymMembership.memberShipRemainingSessions) + StringUtilsConstant.SESSIONS
    }
}
