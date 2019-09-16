//
//  CalorieTrackerViewController.swift
//  Calorie Tracker
//
//  Created by Stephanie Bowles on 9/16/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit
import SwiftChart

class CalorieTrackerViewController: UIViewController {
  
    

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: Chart!
    
    @IBOutlet weak var addItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = [
            (x: 0, y: 0),
            (x: 3, y: 2.5),
            (x: 4, y: 2),
            (x: 5, y: 2.3),
            (x: 7, y: 3),
            (x: 8, y: 2.2),
            (x: 9, y: 2.5)
        ]
        let series = ChartSeries(data: data)
        series.area = true
        
        chartView.yLabels = [0, 200, 600, 1000]
        
//        chartView.xLabelsFormatter = { String(Int(round($1))) + "h" }

        chartView.add(series)
        // Do any additional setup after loading the view.
    }
  
//    let series = ChartSeries([0, 6.5, 2, 8, 4.1, 7, -3.1, 10, 8])

    
   
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
