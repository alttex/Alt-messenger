//
//  ColorsExtensions.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/16/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit

struct GlobalVariables {
    static let blue = UIColor.rbg(r: 129, g: 144, b: 255)
    static let white = UIColor.rbg(r: 255, g: 255, b: 255)
    static let customGray = UIColor.rbg(r: 34, g: 34, b: 34)
}

//Extensions
extension UIColor{
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}
extension UIColor {
    
    //#a6c675
    static func themeColor() -> UIColor {
        return UIColor(displayP3Red: 166 / 255, green: 198 / 255, blue: 117 / 255, alpha: 1.0)
        
    }
    
    static func boarderGray() -> UIColor {
        return UIColor(displayP3Red: 207 / 255, green: 209 / 255, blue: 216 / 255, alpha: 1.0)
    }
    
    
    static func sentRed() -> UIColor {
        return UIColor(displayP3Red: 227 / 255, green: 83 / 255, blue: 84 / 255, alpha: 1.0)
    }
    
    static func receivedGreen() -> UIColor {
        return UIColor(displayP3Red: 98 / 255, green: 236 / 255, blue: 131 / 255, alpha: 1.0)
    }
    
}
