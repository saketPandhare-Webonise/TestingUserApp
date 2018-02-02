//
//  FeedBackTableCell.swift
//  GymShim


import UIKit
import ResponsiveLabel

class FeedBackTableCell: UITableViewCell {
    
    @IBOutlet weak var viewUserFeedBack: UIView!
    @IBOutlet weak var labelUserFeedBack: ResponsiveLabel!
    @IBOutlet weak var imageViewUserPhoto: UIImageView!
    @IBOutlet weak var labelGymNameUserFeedBack: UILabel!
    @IBOutlet weak var labelSubjectUserFeedBack: UILabel!
    @IBOutlet weak var labelTimeUserFeedback: UILabel!
    @IBOutlet weak var viewGymFeedBack: UIView!
    @IBOutlet weak var labelGymFeedBack: ResponsiveLabel!
    @IBOutlet weak var labelMoreGymFeedBack: UILabel!
    @IBOutlet weak var imageViewGymPhoto: UIImageView!
    @IBOutlet weak var labelGymNameGymFeedback: UILabel!
    @IBOutlet weak var labelTimeGymFeedBack: UILabel!
    
    var gymNameAttributedString = NSMutableAttributedString()
    var spacing:CGFloat = 8
    var numberOfLines:Int = 2
    var replyTextlenght:Int = 8
    let labelNumberOfLines:Int = 3
    var userFeedBack = FeedBackList() {
        didSet {
            setUserFeedBackData()
        }
    }
    var gymFeedBack = GymReview() {
        didSet {
            setGymFeedBackData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CommonHelper.addShadowToView(viewUserFeedBack)
        CommonHelper.addShadowToView(viewGymFeedBack)
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        
        labelGymFeedBack.numberOfLines = labelNumberOfLines
        labelUserFeedBack.preferredMaxLayoutWidth = labelUserFeedBack.frame.size.width
        labelGymFeedBack.preferredMaxLayoutWidth = labelGymFeedBack.frame.size.width
        CommonHelper().makeImageRound(imageViewUserPhoto)
        CommonHelper().makeImageRound(imageViewGymPhoto)
    }
    
    /// this function is used to set usercommented data
    func setUserFeedBackData() {
        labelGymNameUserFeedBack.text = userFeedBack.revivedGymName
        labelSubjectUserFeedBack.text = userFeedBack.title
        labelUserFeedBack.text = userFeedBack.userComment
        labelUserFeedBack.numberOfLines = labelNumberOfLines
        labelUserFeedBack.setAttributedText(getAttributedFeedBackText(labelUserFeedBack.text!), withTruncation: true)
        labelUserFeedBack.setAttributedTruncationToken(getTruncatedString())
        labelTimeUserFeedback.text = getTimeForFeedbackSection(userFeedBack.feedBackTime)
        ImageUtility.setAsyncImage(imageViewUserPhoto!, imageUrl: (userFeedBack.reviewerImage), defaultImageName: ImageAssets.USERDEFAULT_IMAGE, completionBlock: nil)
    }
    
    /// this function is used to set Gym replied data
    func setGymFeedBackData() {
        labelGymFeedBack.text = gymFeedBack.gymComment
        labelGymNameGymFeedback.text = labelGymNameUserFeedBack.text! + StringUtilsConstant.REPLIED
        labelGymFeedBack.numberOfLines = labelNumberOfLines
        labelGymFeedBack.setAttributedText(getAttributedFeedBackText(labelGymFeedBack.text!), withTruncation: true)
        labelGymFeedBack.setAttributedTruncationToken(getTruncatedString())
        labelTimeGymFeedBack.text = getTimeForFeedbackSection(gymFeedBack.reviewTime)
        ImageUtility.setAsyncImage(imageViewGymPhoto!, imageUrl: (userFeedBack.revivedGymImage), defaultImageName: ImageAssets.GYM_ICON, completionBlock: nil)
        viewGymFeedBack.backgroundColor = (gymFeedBack.isViewed) ? UIColor.whiteColor() : getFeedBackBackgroundColor()
        gymNameAttributedString = NSMutableAttributedString(string: labelGymNameGymFeedback.text!)
        gymNameAttributedString.addAttribute(NSForegroundColorAttributeName, value: grayColor(), range: NSRange(location:labelGymNameUserFeedBack.text!.length,length:replyTextlenght))
        labelGymNameGymFeedback.attributedText = gymNameAttributedString
    }
}
