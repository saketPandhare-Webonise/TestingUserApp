//
//  GymScheduleVC.swift
//  GymShim
//

import Foundation
import EZSwiftExtensions

class GymScheduleVC: CustomNotificationController, UITableViewDelegate, UITableViewDataSource, ScheduleDataDelegate {
    
    @IBOutlet weak var scrollViewGymSchedule: UIScrollView!
    @IBOutlet weak var imageViewActivityIcon: UIImageView!
    @IBOutlet weak var labelGymActivity: UILabel!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelTotalSessions: UILabel!
    @IBOutlet weak var labelRemainingSessions: UILabel!
    @IBOutlet weak var labelFirstUserName: UILabel!
    @IBOutlet weak var labelSecondUserName: UILabel!
    @IBOutlet weak var labelThirdUserName: UILabel!
    @IBOutlet weak var labelFirstAttendedSession: UILabel!
    @IBOutlet weak var labelSecondAttendedSession: UILabel!
    @IBOutlet weak var labelThirdAttendedSession: UILabel!
    @IBOutlet weak var viewUserSessionInfo: UIView!
    @IBOutlet weak var viewPooledMembership: UIView!
    @IBOutlet weak var labelCurrentMonth: UILabel!
    @IBOutlet weak var buttonAttendance: UIButton!
    @IBOutlet weak var buttonSunday: UIButton!
    @IBOutlet weak var buttonMonday: UIButton!
    @IBOutlet weak var buttonTuesday: UIButton!
    @IBOutlet weak var buttonWednesday: UIButton!
    @IBOutlet weak var buttonThursday: UIButton!
    @IBOutlet weak var buttonFriday: UIButton!
    @IBOutlet weak var buttonSaturday: UIButton!
    @IBOutlet weak var tableViewSchedule: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var attendanceViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewPolledMembershipHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTopSectionHeightConstraint: NSLayoutConstraint!
    var gymScheduleViewModel = GymScheduleViewModel()
    var arrayGymScheduleInformation = [GymScheduleInfo]()
    let lblShowErrorMessage = UILabel()
    var qrCodeImage = UIImage()
    var membershipId: String = ""
    var pooledMembershipHeight: CGFloat = 80  //[Height of pooled membership view]
    var attendanceViewHeight: CGFloat = 255   //[Top card Height,View having Attendance button it]
    var scheduleCellHeight: CGFloat = 62      //[Height of Schedule Cell]
    var parentTopViewHeight: CGFloat = 377 // [Height of parent view TopCard + Schedule + PooledMemberships]
    var numberOfRows: Int = 20 // testing [Number of Rows in schedule]
    var isPooledMembership:Bool = false
    var imageAttendanceInsets: CGFloat = 10
    var errorLabelBottonSpacing: CGFloat = 0
    var errorLabelBottomSpacingWithoutPooledMember: CGFloat = 1.5
    var errorLabelBottomSpacingWithPooledMember: CGFloat = 1.3
    let firstPooledMember: Int = 0
    let secondPooledMember: Int = 1
    let thirdPooledmember: Int = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNotificationButton()
        configureTableView()
        gymScheduleViewModel.gymScheduleApiCall(membershipId)
        gymScheduleViewModel.scheduleDataDelegate = self
        qrCodeClickSetUp()
    }
    
    override func viewWillAppear(animated: Bool) {
        Analytics.trackScreenByGoogleAnalytic(ScreenNames.SCHEDULE_SCREEN)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        initialSetUp()
    }
    
    override func viewDidAppear(animated: Bool) {
        showNoResultFound()
    }
    
    override func viewWillDisappear(animated: Bool) {
        lblShowErrorMessage.removeSubviews()
    }
    
    /// This function is used to add click gesture for qrcode image
    func qrCodeClickSetUp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GymScheduleVC.qrCodeImageTapped))
        imageViewActivityIcon.userInteractionEnabled = true
        imageViewActivityIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// This method is used to configure schedule table view
    func configureTableView() {
        tableViewSchedule.delegate = self
        tableViewSchedule.dataSource = self
        tableViewSchedule.registerNib(UINib(nibName: TableCellIdentifiers.GYM_SCHEDULE_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.GYM_SCHEDULE_TABLE_CELL)
    }
    
    /// This Method Configures Error label that needs to be displayed if no Schedule is found
    func showNoResultFound() {
        lblShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        lblShowErrorMessage.text = StringUtilsConstant.NO_SCHEDULE_FOUND
        lblShowErrorMessage.textAlignment = .Center
        self.view.addSubview(lblShowErrorMessage)
    }
    /**
     this function is used for initial setup of feedback view
     */
    func initialSetUp() {
        errorLabelBottonSpacing = errorLabelBottomSpacingWithoutPooledMember
        CommonHelper.addShadowToView(viewUserSessionInfo)
        buttonAttendance.centerImage(imageAttendanceInsets)
        labelCurrentMonth.text = CommonHelper.getCurrentMonth() + CommonHelper.getCurrentYear()
    }
    
    /// This function is used to hide poolMembership section when pooling is not present ,this will be implemented in next phase ,currently there is no pooling available for any gyms
    func hidePoolMembershipSection() {
        viewPooledMembership.hidden = true
        viewPolledMembershipHeightConstraint.constant = 0
        attendanceViewHeightConstraint.constant = attendanceViewHeight - pooledMembershipHeight
        viewTopSectionHeightConstraint.constant = parentTopViewHeight - pooledMembershipHeight
    }
    
    /// This function is used to update label frame depending upon pooled membership
    func updateErrorLabelFrame() {
        errorLabelBottonSpacing = (!gymScheduleViewModel.isPooledMembershipPresent())  ?  errorLabelBottomSpacingWithoutPooledMember : errorLabelBottomSpacingWithPooledMember
        lblShowErrorMessage.frame = CGRectMake(0,view.size.height/errorLabelBottonSpacing, self.view.frame.size.width, CGFloat(FontSize.TWENTYONE))
    }
    
    /// This function is used to check if pooleddata is avilable or not and set data accordingly 
    func setPooledMembershipData() {
        if (!gymScheduleViewModel.isPooledMembershipPresent()){
            hidePoolMembershipSection()
        }
        if (gymScheduleViewModel.getPooledMembershipArrayCount() > PooledMemberships.firstPooledMember){
            labelFirstUserName.text = gymScheduleViewModel.getFirstPooledUserName()
            labelFirstAttendedSession.text = appendZeroForSingularValue(gymScheduleViewModel.getFirstPooledUserRemainingSession())
        }
        if (gymScheduleViewModel.getPooledMembershipArrayCount() > PooledMemberships.secondPooledMember) {
            labelSecondUserName.text = gymScheduleViewModel.getSecondPooledUserName()
            labelSecondAttendedSession.text = appendZeroForSingularValue(gymScheduleViewModel.getSecondPooledUserRemainingSession())
        }
        if (gymScheduleViewModel.getPooledMembershipArrayCount() > PooledMemberships.thirdPooledMember) {
            labelThirdUserName.text = gymScheduleViewModel.getThirdPooledUserName()
            labelThirdAttendedSession.text = appendZeroForSingularValue(gymScheduleViewModel.getThirdPooledUserRemainingSession())
        }
    }
    
    /// This function is used to configure Scroll View Insets and table view height depending on webservice resposne
    func configureTableViewAndScrollViewHeights() {
        scrollViewGymSchedule.contentInset = UIEdgeInsetsMake(0.0, 0.0, (scheduleCellHeight * CGFloat(arrayGymScheduleInformation.count)) - self.tableViewSchedule.frame.origin.y + pooledMembershipHeight , 0.0)
        tableViewHeightConstraint.constant = (scheduleCellHeight * CGFloat(arrayGymScheduleInformation.count))
        updateErrorLabelFrame()
    }
    
    //MARK: Button Click Event
    @IBAction func buttonAttendanceClicked(sender: AnyObject) {
        NavigationHandler.navigateToMembershipDetials(navigationController!, membershipID:membershipId)
    }
    
    @IBAction func buttonSundayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonSunday)
    }
    
    @IBAction func buttonMondayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonMonday)
    }
    
    @IBAction func buttonTuesdayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonTuesday)
    }
    
    @IBAction func buttonWednesdayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonWednesday)
    }
    
    @IBAction func buttonThursdayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonThursday)
    }
    
    @IBAction func buttonFridayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonFriday)
    }
    
    @IBAction func buttonSaturdayClicked(sender: AnyObject) {
        setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender)
        CommonHelper.setButtonWithRoundedCorners(buttonSaturday)
    }
    
    ///This function will set default background color and Text color for button
    func setDefaultBackgroundAndTextColorForButtonAndReloadTableData(sender: AnyObject) {
        getScheduleArraySelectedDay(sender.tag)
        tableViewSchedule.reloadData()
        CommonHelper.setClearColorForButtonBackground(buttonSunday)
        CommonHelper.setClearColorForButtonBackground(buttonMonday)
        CommonHelper.setClearColorForButtonBackground(buttonTuesday)
        CommonHelper.setClearColorForButtonBackground(buttonWednesday)
        CommonHelper.setClearColorForButtonBackground(buttonThursday)
        CommonHelper.setClearColorForButtonBackground(buttonFriday)
        CommonHelper.setClearColorForButtonBackground(buttonSaturday)
    }
    
    //MARK: Delegate method after WS Call
    ///This method sets data in schedule section after Webservice call
    func setScheduleData() {
        self.title = gymScheduleViewModel.getGymName()
        setPooledMembershipData()
        generateQRCode()
        labelGymActivity.text = gymScheduleViewModel.getGymPlanName()
        labelStartDate.text = gymScheduleViewModel.getMemberShipStartDate()
        labelEndDate.text = gymScheduleViewModel.getMembershipEndDate()
        labelTotalSessions.text = appendZeroForSingularValue(gymScheduleViewModel.getTotalSession()) + getTitleSession(gymScheduleViewModel.getTotalSession())
        labelRemainingSessions.text = appendZeroForSingularValue(gymScheduleViewModel.getRemainingSession()) + getTitleSession(gymScheduleViewModel.getRemainingSession())
        CommonHelper.setButtonWithRoundedCorners(getButtonForTodaysDay(gymScheduleViewModel.getCurrentDay()))
        getScheduleArraySelectedDay(gymScheduleViewModel.getCurrentDay())
        configureTableViewAndScrollViewHeights()
        tableViewSchedule.reloadData()
    }
    
    /// This function will be reomeved in the next Phase with Activity Icon
    func generateQRCode() {
        
        //QR-Code Generation Goes Here ,needs to be implemented
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.qrCodeImage = CommonHelper().generateQRCodeForText(self.gymScheduleViewModel.getNumberToGenerateQRCode())
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                self.imageViewActivityIcon.image = self.qrCodeImage
            }
        }
    }
    
    
    /// This method is used to pick particular array to display schedule ,it depends on selected day
    ///
    /// - parameter selectedDay: day selected by user
    func getScheduleArraySelectedDay(selectedDay: Int) {
        arrayGymScheduleInformation = gymScheduleViewModel.getScheduleForSelectedDay(selectedDay)
        configureTableViewAndScrollViewHeights()
        checkForErrorLabel()
    }
    
    /// This method is used to check which day of the week it is and hilight that button accordingly
    ///
    /// - parameter currentDay: current day received from Webservice
    ///
    /// - returns: button for that day
    func getButtonForTodaysDay(currentDay:Int)->UIButton {
        
        switch currentDay {
            
        case SelectedDay.SUNDAY:
            return buttonSunday
            
        case SelectedDay.MONDAY:
            return buttonMonday
            
        case SelectedDay.TUESDAY:
            return buttonTuesday
            
        case SelectedDay.WEDNESDAY:
            return buttonWednesday
            
        case SelectedDay.THURSDAY:
            return buttonThursday
            
        case SelectedDay.FRIDAY:
            return buttonFriday
            
        case SelectedDay.SATURDAY:
            return buttonSaturday
            
        default: break
            
        }
        return buttonSunday
    }
    
    
    /// This function is used to check condition for showing/hiding error label
    func checkForErrorLabel() {
        (arrayGymScheduleInformation.count == 0) ?  hideErrorLabel(false) :  hideErrorLabel(true)
    }
    
    /// This function is used to show and hide Error label
    ///
    /// - parameter isSchedulePresent: bool value to show and hide label
    func hideErrorLabel(isSchedulePresent: Bool) {
        lblShowErrorMessage.hidden = isSchedulePresent
    }
    
    /// This function is used to enlarge activity QRCode
    func qrCodeImageTapped() {
        let enlargeQRVC = UIStoryboard.mainStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.ENLARGE_QR_VC) as! EnlargeQRVC
        enlargeQRVC.membershipNumber = gymScheduleViewModel.getNumberToGenerateQRCode()
        navigationController?.pushViewController(enlargeQRVC, animated: false)
    }
}
