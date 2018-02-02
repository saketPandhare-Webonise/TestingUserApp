//
//  UserDetailsTableViewCell.swift
//  GymShim
//

import UIKit
class UserDetailsTableViewCell: UITableViewCell {
    @IBOutlet var imageViewAvatar: UIImageView!
    @IBOutlet var labelUserName: UILabel!
    @IBOutlet var laberUserEmail: UILabel!
    @IBOutlet var labelUserContact: UILabel!
    @IBOutlet var buttonEditProfile: UIButton!
    @IBOutlet var viewUserDetails: UIView!
    @IBOutlet var buttonBirthDate: UIButton!
    @IBOutlet var buttonAnniversaryDate: UIButton!
    
    var userDetails: UserDetails! {
        didSet {
            uiSetup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        CommonHelper().makeImageRound(imageViewAvatar)
        CommonHelper.addShadowToView(viewUserDetails)
    }
    
    /**
        UI setup method to set details
     */
    func uiSetup() {
        labelUserName.text = userDetails.name
        laberUserEmail.text = userDetails.email
        labelUserContact.text = userDetails.mobileNo
        let birthDate: String = (userDetails.dob?.isEmpty)! ? StringUtilsConstant.ADD_DATE_OF_BIRTH : StringUtilsConstant.BIRTHDAY +  userDetails.dob!
        buttonBirthDate.setTitle(birthDate, forState: .Normal)
        let anniversaryDate: String = (userDetails.anniversaryDate?.isEmpty)! ? StringUtilsConstant.ADD_ANNIVERSARY : StringUtilsConstant.ANNIVERSARY +  userDetails.anniversaryDate!
        buttonAnniversaryDate.setTitle(anniversaryDate, forState: .Normal)
        buttonBirthDate.userInteractionEnabled = birthDate == StringUtilsConstant.ADD_DATE_OF_BIRTH ? true : false
        buttonAnniversaryDate.userInteractionEnabled = anniversaryDate == StringUtilsConstant.ADD_ANNIVERSARY ? true : false
    }
}
