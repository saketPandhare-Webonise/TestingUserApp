//
//  HomeMembershipCell.swift
//  GymShim


import UIKit
import FSCalendar
import EZSwiftExtensions

class HomeMembershipCell: UITableViewCell,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance{
    @IBOutlet weak var labelGymName: UILabel!
    @IBOutlet weak var labelGymActivity: UILabel!
    @IBOutlet weak var imageViewQRCode: UIImageView!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelToday: UILabel!
    @IBOutlet weak var labelTodayTime: UILabel!
    @IBOutlet weak var labelTotalSessions: UILabel!
    @IBOutlet weak var labelRemainingSesisons: UILabel!
    @IBOutlet weak var buttonQRCode: UIButton!
    @IBOutlet var viewMembershipDetails: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CommonHelper.addShadowToView(viewMembershipDetails)
        self.layoutIfNeeded()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
