//
//  MainPageViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/11/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit
import Charts

class Food {
    var foodName: String?
    var calorie: Double?
    
    init(_ foodName: String , _ calorie: Double) {
        self.calorie = calorie
        self.foodName = foodName
    }
}

class MainPageViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!
    
    var foods = [Food("Garlic", 149.0), Food("Yam", 118.0), Food("Banana", 89.0)]
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func barChartUpdate() {
        let entry1 = BarChartDataEntry(x: 1.0, y: 149.0)
        let entry2 = BarChartDataEntry(x: 2.0, y: 118.0)
        let entry3 = BarChartDataEntry(x: 3.0, y: 89.0)
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3], label: "foods")
        let chartData = BarChartData()
        chartData.addDataSet(dataSet)
        chartView.data = chartData
        chartView.chartDescription?.text = "The foods calorie"
        
        //chartView.notifyDataSetChanged()
    }
}
