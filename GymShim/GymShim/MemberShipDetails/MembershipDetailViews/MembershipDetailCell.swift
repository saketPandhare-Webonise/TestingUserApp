//
//  MembershipDetailCell.swift
//  GymShim


import UIKit
import FSCalendar

protocol CalendarSwipeDelegate {
    func relaodTableData()
}

class MembershipDetailCell: UITableViewCell, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet var viewMembershipDetail: UIView!
    @IBOutlet weak var viewCalendar: FSCalendar!
    @IBOutlet weak var labelGymName: UILabel!
    @IBOutlet weak var labelGymPlantype: UILabel!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelTotalSession: UILabel!
    @IBOutlet weak var labelRemainingSession: UILabel!
    @IBOutlet weak var labelMissed: UILabel!
    @IBOutlet weak var labelAttended: UILabel!
    @IBOutlet weak var labelNoSession: UILabel!
    @IBOutlet weak var labelFirstUserName: UILabel!
    @IBOutlet weak var labelSecondUserName: UILabel!
    @IBOutlet weak var lableThirdUserName: UILabel!
    @IBOutlet weak var labelFirstUserSession: UILabel!
    @IBOutlet weak var labelSecondUserSession: UILabel!
    @IBOutlet weak var labelThirdUserSession: UILabel!
    @IBOutlet weak var imageViewQRCode: UIImageView!
    @IBOutlet weak var viewPooledMembership: UIView!
    @IBOutlet weak var pooledMembershipHeightConstraint: NSLayoutConstraint!
    var memberShipDetailViewModel: MembershipDetailViewModel?
    var calendarSwipeDelegate: CalendarSwipeDelegate?
    let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    var calendarUnit = NSCalendarUnit()
    var nextPage = NSDate()
    var memberShipID:String = ""
    
    let localCalendar = NSCalendar.currentCalendar()
    var totalAttended:Int = 0
    var totalMissed:Int = 0
    var qrCodeImage = UIImage()
    var titleOffset : CGFloat = -1.0
    var titleOffSetY : CGFloat = 0.0
    var memberShipDetails = MembershipDetails() {
        didSet {
            setMembershipDetailData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CommonHelper.addShadowToView(viewMembershipDetail)
    }
    
    /// set membershipDetail Data
    func setMembershipDetailData() {
        labelGymName.text = memberShipDetails.gymName
        labelGymPlantype.text =  memberShipDetails.planName
        labelStartDate.text = memberShipDetails.membershipStartDate
        labelEndDate.text = memberShipDetails.membershipEndDate
        labelTotalSession.text = appendZeroForSingularValue(memberShipDetails.membershipTotalSessions) + getTitleSession(memberShipDetails.membershipTotalSessions)
        labelRemainingSession.text = appendZeroForSingularValue(memberShipDetails.membershipRemainingSessions) + getTitleSession(memberShipDetails.membershipRemainingSessions)
        setPooledMembershipData()
        
        /// QR-Code loads here
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.qrCodeImage = CommonHelper().generateQRCodeForText(self.memberShipDetails.membershipNumber)
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                self.imageViewQRCode.image = self.qrCodeImage
            }
        }
    }
    
    /// This method is used to set data for pooled membership
    func setPooledMembershipData() {
        /// when no pooled membership is present hide that section
        if (!memberShipDetails.isPooledMembershipAvailable){
            viewPooledMembership.hidden = true
            pooledMembershipHeightConstraint.constant = 0
        }
            
        else {
            /// display pooled users from Array depending upon count
            /// first pooled user
            if (memberShipDetails.arrayPooledMembership.count > PooledMemberships.firstPooledMember){
                labelFirstUserName.text = memberShipDetails.arrayPooledMembership[PooledMemberships.firstPooledMember].pooledMemberName
                labelFirstUserSession.text = appendZeroForSingularValue(memberShipDetails.arrayPooledMembership[PooledMemberships.firstPooledMember].pooledRemainingSessions)
            }
            
            /// Second pooled user
            if (memberShipDetails.arrayPooledMembership.count > PooledMemberships.secondPooledMember){
                labelSecondUserName.text = memberShipDetails.arrayPooledMembership[PooledMemberships.secondPooledMember].pooledMemberName
                labelSecondUserSession.text = appendZeroForSingularValue(memberShipDetails.arrayPooledMembership[PooledMemberships.secondPooledMember].pooledRemainingSessions)
            }
            
             /// Third pooled user
            if (memberShipDetails.arrayPooledMembership.count > PooledMemberships.thirdPooledMember){
                lableThirdUserName.text = memberShipDetails.arrayPooledMembership[PooledMemberships.thirdPooledMember].pooledMemberName
                labelThirdUserSession.text = appendZeroForSingularValue(memberShipDetails.arrayPooledMembership[PooledMemberships.thirdPooledMember].pooledRemainingSessions)
            }
        }
    }
    
    //MARK:Button click
    @IBAction func buttonNextTapped(sender: AnyObject) {
        calendarSwipeOnButtonClick(1)
    }
    
    @IBAction func buttonPreviosTapped(sender: AnyObject) {
        calendarSwipeOnButtonClick(-1)
    }
}
