//
//  SettingsViewController.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/19/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//


import UIKit
import CoreData
import Alamofire
import SwiftyStoreKit
import SwiftTheme

class SettingsViewController: UIViewController {
    
    let managedObjectContext = getContext()
    
    @IBOutlet var walletSelector: UISegmentedControl!
    @IBOutlet var themeSelector: UISegmentedControl!
    @IBOutlet var widgetPercentSelector: UISegmentedControl!
    @IBOutlet var feedFormatSelector: UISegmentedControl!
    //@IBOutlet var walletModeView: UIStackView!
    
  

    
    var style: UIStatusBarStyle = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        walletValue = defaults.string(forKey: "CoinAuditWalletMode") ?? "Value"
        widgetPercent = defaults.string(forKey: "CoinAuditWidgetPercent") ?? "24h"
        
        
        
        
        if widgetPercent == "1h" {
            widgetPercentSelector.selectedSegmentIndex = 0
        } else if widgetPercent == "24h" {
            widgetPercentSelector.selectedSegmentIndex = 1
        } else {
            widgetPercentSelector.selectedSegmentIndex = 0
        }
        
        if walletValue == "volume" {
            walletSelector.selectedSegmentIndex = 0
        } else if walletValue == "value" {
            walletSelector.selectedSegmentIndex = 1
        } else {
            walletSelector.selectedSegmentIndex = 0
        }
        
        if themeValue == "light" {
            themeSelector.selectedSegmentIndex = 0
        } else if themeValue == "dark" {
            themeSelector.selectedSegmentIndex = 1
        } else {
            themeSelector.selectedSegmentIndex = 0
        }
        
        if priceFormat == "USD" {
            feedFormatSelector.selectedSegmentIndex = 0
        } else if priceFormat == "BTC" {
            feedFormatSelector.selectedSegmentIndex = 1
        } else {
            feedFormatSelector.selectedSegmentIndex = 0
        }
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        updateTheme()
    }
    
   
    
    @IBAction func themeMode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            themeValue = "light"
        } else {
            themeValue = "dark"
        }
        saveThemeSettings()
        updateTheme()
    }
    
    @IBAction func walletMode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            walletValue = "volume"
        } else {
            walletValue = "value"
        }
        saveWalletSettings()
    }
    
    @IBAction func widgetPercentMode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            widgetPercent = "1h"
        } else {
            widgetPercent = "24h"
        }
        saveWidgetSettings()
    }
    
    @IBAction func feedFormatMode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            priceFormat = "USD"
        } else {
            priceFormat = "BTC"
        }
        savePriceSettings()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch themeValue {
        case "dark":
            return .lightContent
        default:
            return .default
        }
    }
    
    func updateTheme() {
        switch themeValue {
        case "dark":
            ThemeManager.setTheme(index: 0)
        default:
            ThemeManager.setTheme(index: 1)
        }

        self.tabBarController?.tabBar.theme_barTintColor = ["#01b207", "#FFF"]
        self.navigationController?.navigationBar.theme_barTintColor = ["#01b207", "#FFF"]
        self.navigationItem.leftBarButtonItem?.theme_tintColor = ["#000", "#FFF"]
        self.navigationItem.rightBarButtonItem?.theme_tintColor = ["#000", "#FFF"]
        self.navigationController?.navigationBar.theme_tintColor = ["#FFF", "#000"]
        
        self.navigationController?.navigationBar.theme_tintColor = ["#FFF", "#000"]
        self.navigationController?.navigationBar.theme_titleTextAttributes = [[NSAttributedStringKey.foregroundColor.rawValue : UIColor.black], [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]]
        self.navigationController?.navigationBar.theme_largeTitleTextAttributes =  [[NSAttributedStringKey.foregroundColor.rawValue : UIColor.black], [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]]
        self.walletSelector.theme_tintColor = ["#FFF", "#000"]
        self.themeSelector.theme_tintColor = ["#FFF", "#000"]
        self.widgetPercentSelector.theme_tintColor = ["#FFF", "#000"]
        self.walletSelector.theme_tintColor = ["#01b207", "#01b207"]
        self.feedFormatSelector.theme_tintColor = ["#01b207", "#01b207"]
        self.view.theme_backgroundColor = ["#242424", "#242424"]
        
    
        
        UIApplication.shared.statusBarStyle = preferredStatusBarStyle
    }
}
