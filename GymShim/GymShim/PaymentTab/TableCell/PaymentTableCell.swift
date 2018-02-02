//
//  PaymentTableCell.swift
//  GymShim

import UIKit

class PaymentTableCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var labelGymName: UILabel!
    @IBOutlet weak var labelInvoiceNumber: UILabel!
    @IBOutlet weak var labelTotalAmount: UILabel!
    @IBOutlet weak var labelActualTotalAmount: UILabel!
    @IBOutlet weak var labelPaidAmount: UILabel!
    @IBOutlet weak var labelActualPaidAmount: UILabel!
    @IBOutlet weak var labelBalanceAmount: UILabel!
    @IBOutlet weak var labelActualBalanceAmount: UILabel!
    @IBOutlet weak var labelDueDate: UILabel!
    @IBOutlet weak var labelActualDueDate: UILabel!
    
    var rowNo: Int = 0
    var isCompletedTabSelected: Bool = false
    var userPaymentModel: UserPaymentModel = UserPaymentModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CommonHelper.addShadowToView(parentView)
    }
    
    /// This function is used for initial cell setup
    func initialCellSetUp() {
        (isCompletedTabSelected) ? showOrHideBalanceAmountAndDueDate(true) : showOrHideBalanceAmountAndDueDate(false)
        labelPaidAmount.text = (isCompletedTabSelected) ? StringUtilsConstant.PAID_ON : StringUtilsConstant.PAID_AMOUNT
        (isCompletedTabSelected) ? setPaymentData(userPaymentModel.dictionaryPayments.dictionaryPaymentData.arrayCompletedPayment[rowNo]) :
            setPaymentData(userPaymentModel.dictionaryPayments.dictionaryPaymentData.arrayPendingPayment[rowNo])
    }
    
    /// This function is used to show and hide labels as per cell
    /// Parameter:bool value determining if labels should be shown or not
    func showOrHideBalanceAmountAndDueDate(shouldHide: Bool) {
        labelBalanceAmount.hidden = shouldHide
        labelActualBalanceAmount.hidden = shouldHide
        labelDueDate.hidden = shouldHide
        labelActualDueDate.hidden = shouldHide
    }
    
    /// This function is used to set payment data
    func setPaymentData(paymentData: PaymentData) {
        labelGymName.text = paymentData.gymName
        labelInvoiceNumber.text = paymentData.invoiceNumber
        labelActualTotalAmount.text = paymentData.totalAmount
        labelActualPaidAmount.text = (isCompletedTabSelected) ? paymentData.paidDate : paymentData.paidAmount
        labelActualBalanceAmount.text = paymentData.balanceAmount
        labelActualDueDate.text = paymentData.dueDate
    }
}
