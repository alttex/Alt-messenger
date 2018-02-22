//
//  CustomCells.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/17/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//


import Foundation
import UIKit


class SenderCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: RoundedImageView!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var messageBackground: UIImageView!
    
    var screen = UIScreen.main.bounds
   
    
    func clearCellData()  {
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
          self.selectionStyle = .none
        self.messageBackground.layer.frame = CGRect(x: message.frame.maxX, y: message.frame.maxX, width: screen.width-5, height: message.frame.maxX)
        self.messageBackground.layer.cornerRadius = 2
        self.messageBackground.roundCorners(corners: [.topRight,.bottomRight,.bottomLeft], radius: 6)
        self.messageBackground.clipsToBounds = true
    }
}

class ReceiverCell: UITableViewCell {
    
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var messageBackground: UIImageView!
    
     var screen = UIScreen.main.bounds
       func clearCellData()  {
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        //self.message.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        self.messageBackground.layer.frame = CGRect(x: message.frame.maxX, y: message.frame.maxX, width: screen.width-5, height: message.frame.maxX)
        self.messageBackground.layer.cornerRadius = 1
        self.messageBackground.roundCorners(corners: [.topLeft,.bottomRight,.bottomRight], radius: 6)
        
        self.messageBackground.clipsToBounds = true
    }
}

class ConversationsTBCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func clearCellData()  {
        self.nameLabel.font = UIFont(name:"AvenirNext-Regular", size: 17.0)
        self.messageLabel.font = UIFont(name:"AvenirNext-Regular", size: 14.0)
        self.timeLabel.font = UIFont(name:"AvenirNext-Regular", size: 13.0)
        self.profilePic.layer.borderColor = GlobalVariables.white.cgColor
        self.messageLabel.textColor = UIColor.rbg(r: 245, g: 245, b: 245)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePic.layer.borderWidth = 2
        self.profilePic.layer.borderColor = GlobalVariables.white.cgColor
    }
    
}

class ContactsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePic: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}




