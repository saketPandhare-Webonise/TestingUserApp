//
//  UpcomingTrialCell.swift
//  GymShim


import UIKit

class UpcomingTrialCell: UITableViewCell {

    @IBOutlet weak var labelGymName: UILabel!
    @IBOutlet weak var labelTrialName: UILabel!
    @IBOutlet weak var labelSessionDate: UILabel!
    @IBOutlet weak var labelAttendance: UILabel!
    @IBOutlet weak var labelSessionTime: UILabel!
    @IBOutlet weak var viewTrialBackground: UIView!
    @IBOutlet weak var imageViewQRCode: UIImageView!
    @IBOutlet weak var buttonQRCode: UIButton!
    
    var gymTrials = GymTrials() {
        didSet {
            uiSetup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CommonHelper.addShadowToView(viewTrialBackground)
        self.layoutIfNeeded()
    }
    
    /**
     UI setup method to set trial details
     */
    func uiSetup() {
        labelGymName.text =  gymTrials.gymName
        labelSessionDate.text = gymTrials.trialDate
        labelTrialName.text = StringUtilsConstant.GYM_TRIAL
        labelSessionTime.text = gymTrials.trialTime
    }
}
