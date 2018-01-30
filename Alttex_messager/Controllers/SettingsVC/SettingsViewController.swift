//
//  SettingsViewController.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/19/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    var settingsArray = ["Profile settings", "Messages settings", "Geolocation", "Wallet settings", "Shop settings"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.emailTxtField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.nameTxtField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
       tableView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell")
        cell?.textLabel?.text = settingsArray[indexPath.row]
        cell?.textLabel?.textColor = .white
        return cell!
    }

}

