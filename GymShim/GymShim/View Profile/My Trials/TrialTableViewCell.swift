//
//  TrialTableViewCell.swift
//  GymShim
//

import UIKit

class TrialTableViewCell: UITableViewCell {
    @IBOutlet var labelGymName: UILabel!
    @IBOutlet var labelPlanName: UILabel!
    @IBOutlet var labelSessionDate: UILabel!
    @IBOutlet var viewMyTrialDetails: UIView!
    @IBOutlet var labelSessionTime: UILabel!
    @IBOutlet weak var labelTrialStatus: UILabel!
    var gymTrials = GymTrials() {
        didSet {
            uiSetup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CommonHelper.addShadowToView(viewMyTrialDetails)
    }
    
    /**
     UI setup method to set trial details
     */
    func uiSetup() {
        labelGymName.text =  gymTrials.gymName
        labelSessionDate.text = gymTrials.trialDate
        labelPlanName.text = StringUtilsConstant.GYM_TRIAL
        labelSessionTime.text = gymTrials.trialTime
        labelTrialStatus.hidden = showTrialAttendanceLabel(gymTrials.trialType)
        labelTrialStatus.text = getTrialStatusText(gymTrials.trialStatus)
        labelTrialStatus.textColor = getTrialStatusTextColor(gymTrials.trialStatus)
    }
}
