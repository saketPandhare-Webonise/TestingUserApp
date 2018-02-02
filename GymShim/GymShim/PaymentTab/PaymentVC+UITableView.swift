//
//  PaymentVC+UITableView.swift
//  GymShim


import UIKit

extension PaymentVC {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentViewModel.getNumberOfRows()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (isCompletedTabSelected) ? COMPLETE_PAYMENT_CELL_HEIGHT : PENDING_AMOUNT_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return constructPendingAmountCell(tableView, indexPath: indexPath)
    }
    
    /// This function is used to construct Pending amount cell
    /// Parameters: Tableview
    /// Parameters: indexPath
    /// return: Tablecell
    func constructPendingAmountCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let pendingAmoutCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.PAYMENT_TABLE_CELL) as! PaymentTableCell
        pendingAmoutCell.isCompletedTabSelected = isCompletedTabSelected
        pendingAmoutCell.userPaymentModel = paymentViewModel.userPaymentModel
        pendingAmoutCell.rowNo = indexPath.row
        pendingAmoutCell.initialCellSetUp()
        return pendingAmoutCell
    }
}
