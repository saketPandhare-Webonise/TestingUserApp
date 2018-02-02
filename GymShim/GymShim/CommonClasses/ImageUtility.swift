//
//  ImageUtility.swift
//  GymShim

import Foundation
import SDWebImage

class ImageUtility {
    /**
     setting image loading from server asyncronously
     
     - parameter imageView:        imageView object which has image object to load
     - parameter imageUrl:         url path to load image
     - parameter defaultImageName: placeholder image to show till image loads
     - parameter completionBlock:  completion block to handle events after image loads
     */
    static func setAsyncImage(imageView: UIImageView,
                              imageUrl: String,
                              defaultImageName: String,
                              completionBlock: SDWebImageCompletionBlock?) {
        
        //set about me images asynchronously
        imageView.setShowActivityIndicatorView(true)
        imageView.setIndicatorStyle(.Gray)
        
        let partnerImage = NSURL(string: imageUrl)
        let placeholderImage = UIImage(named: defaultImageName)
        
        imageView.sd_setImageWithURL(partnerImage,
                                     placeholderImage: placeholderImage,
                                     completed: completionBlock)
        
    }
    
    /**
     Makes image circular in shape
     
     - parameter image: image to be turned circular
     */
    static func makeImageCircular(image:UIImageView) {
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.whiteColor().CGColor
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
    }
    
    class func imageToBase64 (image : UIImage) -> String {
        
        let imgToBase64 : NSString = UIImagePNGRepresentation(image)!.base64EncodedStringWithOptions([])
        
        return imgToBase64 as String
    }
    
    /// this func will flip the image if image is not proper and returns the flipped image
    static func getFlipImage(image:UIImage)->UIImage{
        if (image.imageOrientation == UIImageOrientation.Up) {
            return image;
        }
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        image.drawInRect(rect)
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
    
//    static func getImageForTabBar(image:UIImage, size: CGSize)->UIImage {
//        let rect: CGRect = CGRectMake(0, 0, size.width, size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
}

