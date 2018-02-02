//
//  AboutGymshimTableViewCell.swift
//  GymShim
//

import UIKit
import ResponsiveLabel

class AboutGymshimTableViewCell: UITableViewCell {
   
    @IBOutlet weak var labelAboutGymShim: UILabel!
    
    let labelSpacingConstant: CGFloat = 24
    var aboutGym = NSMutableAttributedString()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       labelAboutGymShim.text = StringUtilsConstant.ABOUT_GYM
       labelAboutGymShim.addTextSpacing(labelSpacingConstant)
       labelAboutGymShim.font =  UIFont(name: FontFamilies.FONTFAMILY_HELVETICA_MEDIUM, size: CGFloat(FontSize.SIXTEEN))
       labelAboutGymShim.lineBreakMode = .ByTruncatingTail
    }
}
