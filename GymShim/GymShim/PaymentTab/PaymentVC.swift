//
//  PaymentVC.swift
//  GymShim

import UIKit

class PaymentVC: CustomNotificationController, UITableViewDelegate, UITableViewDataSource, PaymentAPIDelegate {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var buttonPending: UIButton!
    @IBOutlet weak var buttonCompleted: UIButton!
    @IBOutlet weak var tableViewPayment: UITableView!
    
    var isCompletedTabSelected: Bool = false
    var paymentViewModel: PaymentViewModel = PaymentViewModel()
    let PENDING_AMOUNT_CELL_HEIGHT: CGFloat = 180
    let COMPLETE_PAYMENT_CELL_HEIGHT: CGFloat = 130
    let ERROR_LABEL_HEIGHT: CGFloat = 150
    let ERROR_LABEL_LINES = 2
    let lblShowErrorMessage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        paymentViewModel.paymentAPIDelegate = self
        hideBackButton()
        addLogoAsNavigationTitle()
        initialSetUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function is used to do initial setup of paymentVC
    func initialSetUp() {
        lblShowErrorMessage.hidden = true
        showNoResultFound()
        parentView.backgroundColor = getAppThemeColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = true
        tableViewPayment.delegate = self
        tableViewPayment.dataSource = self
        tableViewPayment.registerNib(UINib(nibName: TableCellIdentifiers.PAYMENT_TABLE_CELL,bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PAYMENT_TABLE_CELL)
    }
    
    override func viewWillAppear(animated: Bool) {
         paymentViewModel.getPaymentData()
    }
    
    override func viewDidLayoutSubviews() {
        if (!isCompletedTabSelected) {
         buttonPending.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonPending, isSelected: true))
        }
    }
    
    //MARK: Button Click Event
    @IBAction func buttonPendingTapped(sender: AnyObject) {
        updateUIOnButtonClickEvent(false)
    }
    
    @IBAction func buttonCompletedTapped(sender: AnyObject) {
        updateUIOnButtonClickEvent(true)
    }
    
    /// This function is used to update UI on Button click
    /// parameters: bool value 
    func updateUIOnButtonClickEvent(isSelected: Bool) {
        isCompletedTabSelected = isSelected
        buttonPending.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonPending, isSelected: !isSelected))
        buttonCompleted.layer.addSublayer(CommonHelper.setBorderToButtonBelow(buttonPending, isSelected: isSelected))
        paymentViewModel.isCompletedTabSelected = isCompletedTabSelected
        didReveivePaymentData()
    }
    
    //MARK : WebService Delegate Method
    func didReveivePaymentData() {
        lblShowErrorMessage.hidden = (paymentViewModel.getNumberOfRows() == 0) ? false : true
        tableViewPayment.reloadData()
    }
    
    //show Error Message if no result Found
    func showNoResultFound() {
        lblShowErrorMessage.frame = CGRectMake(0,self.view.frame.size.height/2 - (ERROR_LABEL_HEIGHT), self.view.frame.size.width, CGFloat(ERROR_LABEL_HEIGHT))
        lblShowErrorMessage.font = UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.FOURTEEN))
        lblShowErrorMessage.text = ValidationConstants.NO_PAYMENT
        lblShowErrorMessage.numberOfLines = ERROR_LABEL_LINES
        lblShowErrorMessage.textAlignment = .Center
        tableViewPayment .addSubview(lblShowErrorMessage)
    }
}
