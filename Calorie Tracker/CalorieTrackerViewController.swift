//
//  CalorieTrackerViewController.swift
//  Calorie Tracker
//
//  Created by Stephanie Bowles on 9/16/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit
import SwiftChart

class CalorieTrackerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    
     let calorieController = CalorieController()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: Chart!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

    
   
    @IBAction func addButtonPressed(_ sender: Any) {
        alertCalorieEntry()
    }
    
    func alertCalorieEntry() {
        let alert = UIAlertController(title: "Add Calorie Intake", message: "Enter the amount of calories in the field", preferredStyle: .alert)
        
        var calorieTextField: UITextField!
        alert.addTextField { (textField) in
            textField.placeholder = "Calorie:"
            calorieTextField = textField
        }
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
            guard let amount =  calorieTextField.text, !amount.isEmpty else {return}
            
            self.calorieController.addCalories(with: amount)
            self.tableView.reloadData() 
            
            //post a notification here
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calorieController.calories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieAmount", for: indexPath)
        
        let tracker = calorieController.calories[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let dateString = dateFormatter.string(from: tracker.date ?? Date())
        
        cell.textLabel?.text = ("Calories: \(tracker.calories)")
        cell.detailTextLabel?.text = dateString
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
