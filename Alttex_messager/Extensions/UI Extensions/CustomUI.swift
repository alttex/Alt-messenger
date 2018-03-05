//
//  CustomUI.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/17/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}


extension UIImageView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}



extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let rect = self.bounds
        let mask = CAShapeLayer()
        mask.frame = rect
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
