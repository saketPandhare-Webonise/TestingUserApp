//
//  MyTrialsTableViewCell.swift
//  GymShim
//

import UIKit

class MyTrialsTableViewCell: UITableViewCell {
    @IBOutlet var labelMyTrialsHeader: UILabel!
    @IBOutlet var labelGymName: UILabel!
    @IBOutlet var labelGymPlan: UILabel!
    @IBOutlet var labelSessionDate: UILabel!
    @IBOutlet var labelTimeOfTrial: UILabel!
    @IBOutlet var buttonViewAllTrials: UIButton!
    @IBOutlet var imageViewArrow: UIImageView!
    @IBOutlet var viewAll: UIView!
    @IBOutlet var labelViewAll: UILabel!
    @IBOutlet var constraintViewAllHeight: NSLayoutConstraint!
    @IBOutlet var viewHorizontalBar: UIView!
    @IBOutlet var viewMyTrials: UIView!
    @IBOutlet weak var labelTrialStatus: UILabel!
    
    var count:Int = 0
    var gymTrials = GymTrials() {
        didSet {
            uiSetup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CommonHelper.addShadowToView(viewMyTrials)
    }
    
    /**
     UI setup method to set trial details
     */
    func uiSetup() {
        //checks the count of memberships, if it is one then sets title as membership else membership
        labelMyTrialsHeader.text = count == NumberConstant.ONE ? StringUtilsConstant.MY_TRIALS + StringUtilsConstant.OPENING_BRACKETS + String(format: StringUtilsConstant.TWO_DIGIT_FORMAT, count) + StringUtilsConstant.CLOSING_BRACKETS : StringUtilsConstant.MY_TRIALS + StringUtilsConstant.OPENING_BRACKETS + String(format: StringUtilsConstant.TWO_DIGIT_FORMAT, count) + StringUtilsConstant.CLOSING_BRACKETS
        
        labelGymName.text =  gymTrials.gymName
        labelSessionDate.text = gymTrials.trialDate
        labelGymPlan.text = StringUtilsConstant.GYM_TRIAL
        labelTimeOfTrial.text = gymTrials.trialTime
        labelTrialStatus.hidden = showTrialAttendanceLabel(gymTrials.trialType)
        labelTrialStatus.text = getTrialStatusText(gymTrials.trialStatus)
        labelTrialStatus.textColor = getTrialStatusTextColor(gymTrials.trialStatus)
    }
}
