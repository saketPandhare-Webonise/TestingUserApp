//
//  FeedBackVC+TableView.swift
//  GymShim


import UIKit

extension FeedBackVC {
    
    //MARK:TableViewDelegate Delegate Method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedBackViewModel.getTotalNumberOfSection()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return feedBackViewModel.getFeedBackObjectFromArray(indexPath).dictionaryGymComment.gymComment .isEmpty  ? TABLE_CELL_HEIGHT - USERCOMMENT_SECTION_HEIGHT : TABLE_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return constructFeebBackTableCell(tableViewFeedBack, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let feedbackDetailVC = UIStoryboard.mainStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifires.FEEDBACK_DEATILS) as? FeedBackDetailsVC
        feedbackDetailVC!.gymFeedBack = feedBackViewModel.getFeedBackObjectFromArray(indexPath).dictionaryGymComment
        feedbackDetailVC!.userFeedBack = feedBackViewModel.getFeedBackObjectFromArray(indexPath)
         makeWebserviceCall = false
        feedbackDetailVC!.replyViwedDelegate = self
        feedbackDetailVC!.fromViewController = .FromFeedBackScreen
        pushVC(feedbackDetailVC!)
    }
    
    /// Construct FeedBack Cell That needs to be diaplyed on FeedbackTable View
    ///
    /// - parameter tableView: tableViewFeedBack
    /// - parameter indexPath: indeXpath of tableview
    ///
    /// - returns: tableViewCell
    func constructFeebBackTableCell(tableView:UITableView, indexPath:NSIndexPath)->UITableViewCell{
        let feedBackTableCell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifiers.FEEDBACK_TABLE_CELL) as! FeedBackTableCell
        feedBackTableCell.layoutSubviews()
        feedBackTableCell.userFeedBack = feedBackViewModel.getFeedBackObjectFromArray(indexPath)
        feedBackTableCell.gymFeedBack = feedBackViewModel.getFeedBackObjectFromArray(indexPath).dictionaryGymComment
        (feedBackViewModel.getFeedBackObjectFromArray(indexPath).dictionaryGymComment.gymComment .isEmpty) ?  (feedBackTableCell.viewGymFeedBack.hidden = true) : (feedBackTableCell.viewGymFeedBack.hidden = false)
        return feedBackTableCell
    }
    
    //MARK:SCrollView Delegate Method
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (feedBackViewModel.feedBackListSet.count < feedBackViewModel.getMaximumFeedBackPresent()){
        feedBackViewModel.incrementPageNo()
        feedBackViewModel.getUserFeedBacks()
     }
    }
}
