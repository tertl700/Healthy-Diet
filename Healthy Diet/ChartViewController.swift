//
//  ChartViewController.swift
//  Healthy Diet
//
//  Created by Zefeng Li on 5/12/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var lineChart: LineChartView!
    var numbers: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setChartValues()
        
    }
    
    func setChartValues(_ count: Int = 7) {
        var values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double.random(in: 100...200)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let date = 0
        let weight: Double = Double(weightField.text!) ?? 0
        let currentEntry: ChartDataEntry = ChartDataEntry(x: Double(date), y: weight)
        
        values[date] = currentEntry
        
        let set1 = LineChartDataSet(values: values, label: "Date")
        let data = LineChartData(dataSet: set1)
        
        self.lineChart.data = data
    }
    
    @IBAction func changeButtonClicked(_ sender: Any) {
        let input = Double(weightField.text!)
        numbers.append(input!)
        updateGraph()
        weightField.text = ""
        
    }
    
    func updateGraph(){
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        
        data.addDataSet(line1)
        
        lineChart.data = data
        lineChart.chartDescription?.text = "Weight Tracker"
    }
    
    

}
