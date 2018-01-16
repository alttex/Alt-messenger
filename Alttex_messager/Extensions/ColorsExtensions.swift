//
//  ColorsExtensions.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/16/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        let maxValue : CGFloat = 255
        return UIColor(red: r / maxValue, green: g / maxValue, blue: b / maxValue, alpha: a)
    }
    
    open class var customGreyWithOpacity : UIColor {
        return UIColor.rgba(17, 17, 17, 0.1)
    }
    
    open class var customLightBlue : UIColor {
        return UIColor.rgba(151, 187, 240, 1)
    }
    
    open class var customLightGrey : UIColor {
        return UIColor.rgba(248, 248, 248, 1)
    }
    
    open class var customPurple : UIColor {
        return UIColor.rgba(157, 181, 240, 1)
    }
}
