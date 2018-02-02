//
//  LogoutTableViewCell.swift
//  GymShim
//

import UIKit

class LogoutTableViewCell: UITableViewCell {
    @IBOutlet var labelLogout: UILabel!
    @IBOutlet var viewCard: UIView!
    @IBOutlet weak var imageViewLogOut: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        CommonHelper.addShadowToView(viewCard)
    }
}
