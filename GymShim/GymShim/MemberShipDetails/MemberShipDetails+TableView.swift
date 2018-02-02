//
//  MemberShipDetails+TableView.swift
//  GymShim


import UIKit

extension MemberShipDetailsVC {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberConstant.ONE
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(TableCellHeight.MEMBERSHIP_DETAIL_HEIGHT) +  isPooledMembership()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return constructMembershipCell(tableView, indexPath: indexPath)
    }
    
    /// This function is used to construct MemberShipCell
    ///
    /// - parameter tableView: Membership TableView
    /// - parameter indexPath: IndexPath
    ///
    /// - returns: TableCell
    func constructMembershipCell(tableView: UITableView,indexPath: NSIndexPath)->UITableViewCell{
        let memberShipDetailsCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.MEMBERSHIP_DETAILS_CELL) as! MembershipDetailCell
        memberShipDetailsCell.calendarSwipeDelegate = self
        memberShipDetailsCell.memberShipDetailViewModel = memberShipDetailViewModel
        memberShipDetailsCell.memberShipID = memberShipID
        (shouldCreateCalendar) ? memberShipDetailsCell.calendarSetUp() :  memberShipDetailsCell.reloadCalendarView()
        /// change flag here for Calendar.Also set calendar only for first time when user changes the month just reload it
        shouldCreateCalendar = false
        memberShipDetailsCell.memberShipDetails   = memberShipDetailViewModel.memberShipDetailModel.dictionaryMembershipDetail
        setTapActionToQrCode(memberShipDetailsCell)
        return memberShipDetailsCell
    }
    
    /// This function is used to set tap action on QRCode image
    /// - parameter membershipDetailCell:MembershipDetailCell
    func setTapActionToQrCode(memberShipDetailsCell: MembershipDetailCell) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemberShipDetailsVC.qrCodeImageTapped))
        memberShipDetailsCell.imageViewQRCode.userInteractionEnabled = true
        memberShipDetailsCell.imageViewQRCode.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// This function is used to check if pooled membership is present or not
    /// return: bool value
    func isPooledMembership()->CGFloat{
        
        return (memberShipDetailViewModel.memberShipDetailModel.dictionaryMembershipDetail.isPooledMembershipAvailable) ?
            pooledViewSize : CGFloat(NumberConstant.ZERO)
        
    }
    
    /// This function is used to enlarge activity QRCode
    func qrCodeImageTapped() {
        let enlargeQRVC = UIStoryboard.mainStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.ENLARGE_QR_VC) as! EnlargeQRVC
        enlargeQRVC.membershipNumber = memberShipDetailViewModel.memberShipDetailModel.dictionaryMembershipDetail.membershipNumber
        navigationController?.pushViewController(enlargeQRVC, animated: false)
    }
}
