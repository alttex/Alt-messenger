//
//  WalletTableViewCell.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/18/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import UIKit


class WalletTableViewCell: UITableViewCell,BEMCheckBoxDelegate {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.coinName.textColor = .white
         self.coinPrice.textColor = .white
        self.checkBox.onAnimationType = .fade
        
    }

   
    func didTap(_ checkBox: BEMCheckBox) {
        print("You tapped\(checkBox.tag)")
        
        
    }
    
}
