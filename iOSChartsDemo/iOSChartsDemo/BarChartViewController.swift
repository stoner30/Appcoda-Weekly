//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Stoner Wang on 15/9/25.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        barChartView.delegate = self
        
        // 如果图表视图中无数据，可以显示一些自定义的提示信息
        // barChartView.noDataText = "You need to provide data for the chart."
        // barChartView.noDataTextDescription = "GIVE REASON"
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
        barChartView.data = chartData
        barChartView.descriptionText = "Ferrari Sales Summary"
        
        // 自定义图表中各柱形的颜色，如果颜色的个数少于采样个数，则循环使用颜色
        // chartDataSet.colors = [UIColor(red: 230 / 255, green: 126 / 255, blue: 34 / 255, alpha: 1)]
        
        // 也可以采用预设的颜色集
        chartDataSet.colors = ChartColorTemplates.vordiplom()
        
        // 变更X轴标签的位置
        barChartView.xAxis.labelPosition = .Bottom
        
        // 变更图表的背景色
        // 这个颜色不好看，就注掉吧……
        // barChartView.backgroundColor = UIColor(red: 189 / 255, green: 195 / 255, blue: 199 / 255, alpha: 1)
        
        // 加入动画效果
        // barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: .EaseInOutCubic)
        
        // 加入Limit Line，方便使用者直观的了解是否达到目标
        let limitLine = ChartLimitLine(limit: 10.0, label: "Target")
        barChartView.rightAxis.addLimitLine(limitLine)
    }
    
    // 自定义点选图表中数据条的操作
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \(months[entry.xIndex])")
    }
    
    @IBAction func saveChart(sender: UIBarButtonItem) {
        barChartView.saveToCameraRoll()
    }

}
