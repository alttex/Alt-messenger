//
//  DemoViewController.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/18/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import UIKit
import Charts

enum Option {
    case toggleValues
    case toggleIcons
    case toggleHighlight
    case animateX
    case animateY
    case animateXY
    case saveToGallery
    case togglePinchZoom
    case toggleAutoScaleMinMax
    case toggleData
    case toggleBarBorders
    // CandleChart
    case toggleShadowColorSameAsCandle
    // CombinedChart
    case toggleLineValues
    case toggleBarValues
    case removeDataSet
    // CubicLineSampleFillFormatter
    case toggleFilled
    case toggleCircles
    case toggleCubic
    case toggleHorizontalCubic
    case toggleStepped
    // HalfPieChartController
    case toggleXValues
    case togglePercent
    case toggleHole
    case spin
    case drawCenter
    // RadarChart
    case toggleXLabels
    case toggleYLabels
    case toggleRotate
    case toggleHighlightCircle
    
    var label: String {
        switch self {
        case .toggleValues: return "Toggle Y-Values"
        case .toggleIcons: return "Toggle Icons"
        case .toggleHighlight: return "Toggle Highlight"
        case .animateX: return "Animate X"
        case .animateY: return "Animate Y"
        case .animateXY: return "Animate XY"
        case .saveToGallery: return "Save to Camera Roll"
        case .togglePinchZoom: return "Toggle PinchZoom"
        case .toggleAutoScaleMinMax: return "Toggle auto scale min/max"
        case .toggleData: return "Toggle Data"
        case .toggleBarBorders: return "Toggle Bar Borders"
        // CandleChart
        case .toggleShadowColorSameAsCandle: return "Toggle shadow same color"
        // CombinedChart
        case .toggleLineValues: return "Toggle Line Values"
        case .toggleBarValues: return "Toggle Bar Values"
        case .removeDataSet: return "Remove Random Set"
        // CubicLineSampleFillFormatter
        case .toggleFilled: return "Toggle Filled"
        case .toggleCircles: return "Toggle Circles"
        case .toggleCubic: return "Toggle Cubic"
        case .toggleHorizontalCubic: return "Toggle Horizontal Cubic"
        case .toggleStepped: return "Toggle Stepped"
        // HalfPieChartController
        case .toggleXValues: return "Toggle X-Values"
        case .togglePercent: return "Toggle Percent"
        case .toggleHole: return "Toggle Hole"
        case .spin: return "Spin"
        case .drawCenter: return "Draw CenterText"
        // RadarChart
        case .toggleXLabels: return "Toggle X-Labels"
        case .toggleYLabels: return "Toggle Y-Labels"
        case .toggleRotate: return "Toggle Rotate"
        case .toggleHighlightCircle: return "Toggle highlight circle"
        }
    }
}

class ChartsVC: UIViewController, ChartViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    var options: [Option]!
    var cryptoName = ["BTC","ETH","DASH", "MAID", "MCAP", "MCO", "NEOS","ZEC"]
    var cryptoPrice = ["13006$","2098$","1161$", "212.5$", "956$", "457.7$", "396.3$","559.8$"]
    
    var shouldHideData: Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Wallets"
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }
    
    private func initialize() {
        self.edgesForExtendedLayout = []
    }
    
    func optionTapped(_ option: Option) {}
    
    func handleOption(_ option: Option, forChartView chartView: ChartViewBase) {
        switch option {
        case .toggleValues:
            for set in chartView.data!.dataSets {
                set.drawValuesEnabled = !set.drawValuesEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleIcons:
            for set in chartView.data!.dataSets {
                set.drawIconsEnabled = !set.drawIconsEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleHighlight:
            chartView.data!.highlightEnabled = !chartView.data!.isHighlightEnabled
            chartView.setNeedsDisplay()
            
        case .animateX:
            chartView.animate(xAxisDuration: 3)
            
        case .animateY:
            chartView.animate(yAxisDuration: 3)
            
        case .animateXY:
            chartView.animate(xAxisDuration: 3, yAxisDuration: 3)
            
        case .saveToGallery:
            UIImageWriteToSavedPhotosAlbum(chartView.getChartImage(transparent: false)!, nil, nil, nil)
            
        case .togglePinchZoom:
            let barLineChart = chartView as! BarLineChartViewBase
            barLineChart.pinchZoomEnabled = !barLineChart.pinchZoomEnabled
            chartView.setNeedsDisplay()
            
        case .toggleAutoScaleMinMax:
            let barLineChart = chartView as! BarLineChartViewBase
            barLineChart.autoScaleMinMaxEnabled = !barLineChart.isAutoScaleMinMaxEnabled
            chartView.notifyDataSetChanged()
            
        case .toggleData:
            shouldHideData = !shouldHideData
            updateChartData()
            
        case .toggleBarBorders:
            for set in chartView.data!.dataSets {
                if let set = set as? BarChartDataSet {
                    set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
                }
            }
            chartView.setNeedsDisplay()
        default:
            break
        }
    }
 
    func updateChartData() {
        fatalError("updateChartData not overridden")
    }
    
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 10, top: 10, right: 10, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 13)!,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
        chartView.centerAttributedText = centerText;
        
        chartView.drawHoleEnabled = false
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 9
        l.yEntrySpace = 0
        l.yOffset = 4
        //        chartView.legend = l
    }
    
    func setup(radarChartView chartView: RadarChartView) {
        chartView.chartDescription?.enabled = true
        
    }
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = true
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
     
        
        chartView.rightAxis.enabled = false
    }
    // TODO: Cannot override from extensions
    //extension DemoBaseViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}

extension ChartsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoName.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 40
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! WalletTableViewCell
        
        cell.coinName?.text = cryptoName[indexPath.row]
        cell.coinPrice.text = cryptoPrice[indexPath.row]
        cell.coinName?.textColor = .white
        cell.coinImage.image = UIImage(named: cryptoName[indexPath.row])
        
        
        return cell
    }
    
  
}

