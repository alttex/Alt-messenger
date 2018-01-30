//
//  WalletsVC.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/18/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit
import Charts

class WalletsViewController: ChartsVC {
    
    @IBAction func addCoinBtn(_ sender: UIBarButtonItem) {
     
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "allCoinsVC") //as! NavVC
        self.present(vc!, animated: false, completion: nil)
    }
    @IBOutlet var chartView: BarChartView!
    @IBAction func moreBtnTapped(_ sender: UIBarButtonItem) {
        handleOption(Option.saveToGallery, forChartView: chartView)
    }
    
    let dataLabels = ["100",
                      "200",
                      "300",
                      "400",
                      "500",
                      "600"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wallets"
        self.navigationController?.navigationBar.barTintColor = .white
        chartView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        chartView.highlightPerDragEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.autoScaleMinMaxEnabled = false
        chartView.fitBars = false
         handleOption(Option.animateXY, forChartView: chartView)
        // Do any additional setup after loading the view.
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData,
                        .toggleBarBorders]
        
        self.setup(barLineChartView: chartView)
        
        chartView.delegate = self
        
        chartView.setExtraOffsets(left: 12, top: -10, right: 12, bottom: 10)
        
        chartView.drawBarShadowEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.xAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.drawBarShadowEnabled = false
        
        
        let leftAxis = chartView.leftAxis
        leftAxis.drawLabelsEnabled = false
        leftAxis.spaceTop = 0.25
        leftAxis.spaceBottom = 0.25
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawZeroLineEnabled = true
        leftAxis.zeroLineColor = .white
        leftAxis.zeroLineWidth = 1.5
        
        self.updateChartData()
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
    }
    
    func setChartData() {
        let yVals = [BarChartDataEntry(x: 0, y: -224.1),
                     BarChartDataEntry(x: 1, y: 238.5),
                     BarChartDataEntry(x: 2, y: 1280.1),
                     BarChartDataEntry(x: 3, y: -442.3),
                     BarChartDataEntry(x: 4, y: -2280.1),
                     BarChartDataEntry(x: 5, y: 1991.1)]
        
        let green = UIColor(red: 228/255, green: 32/255, blue: 30/255, alpha: 1)
        let red = UIColor(red: 31/255, green: 228/255, blue: 24/255, alpha: 1)
        let colors = yVals.map { (entry) -> NSUIColor in
            return entry.y > 0 ? red : green
        }
        
        let set = BarChartDataSet(values: yVals, label: "Values")
        set.colors = colors
        set.valueColors = colors
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 13))
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.barWidth = 0.8
        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
}

extension WalletsViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dataLabels[min(max(Int(value), 0), dataLabels.count - 1)]
    }
}




