//
//  CalorieTrackerViewController.swift
//  Calorie Tracker
//
//  Created by Stephanie Bowles on 9/16/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit
import SwiftChart
import CoreData
class CalorieTrackerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    
     let calorieController = CalorieController()
    lazy var fetchedResultsController:
        NSFetchedResultsController<Calorie> = {
            let fetchRequest: NSFetchRequest<Calorie> = Calorie.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
            frc.delegate = self
            try? frc.performFetch()
            return frc
    }()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: Chart!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        renderChart()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        addCaloriesToAll()
//        let data = [
//            (x: 0, y: 0),
//            (x: 3, y: 2.5),
//            (x: 4, y: 2),
//            (x: 5, y: 2.3),
//            (x: 7, y: 3),
//            (x: 8, y: 2.2),
//            (x: 9, y: 2.5)
//        ]
//        let series = ChartSeries(data: data)
//        series.area = true
//
//        chartView.yLabels = [0, 200, 600, 1000]
//
//
//
//        chartView.add(series)
  
    }
  
 

    
   
    @IBAction func addButtonPressed(_ sender: Any) {
        alertCalorieEntry()
    }
    
    func renderChart() {
        var data : [(x: Double, y: Double)] = []
        var index = Double(0)
        for calorie in fetchedResultsController.fetchedObjects! {
            data.append((x: index, y: Double(calorie.calories)))
            index += Double(1)
        }
        let series = ChartSeries(data: data)
        series.area = true
        chartView.gridColor = .gray
        chartView.add(series)
        series.color = ChartColors.cyanColor()
        chartView.highlightLineColor = .red
    }
    @objc func refreshViews(notification: Notification) {
        //        let data = [
        //            (x: 0, y: 0),
        //            (x: 3, y: 2.5),
        //            (x: 4, y: 2),
        //            (x: 5, y: 2.3),
        //            (x: 7, y: 3),
        //            (x: 8, y: 2.2),
        //            (x: 9, y: 2.5)
        //        ]
        //        let series = ChartSeries(data: data)
        //        series.area = true
        //
        //        chartView.yLabels = [0, 200, 600, 1000]
        //
        //
        //
        //        chartView.add(series)
        
       renderChart()
       tableView.reloadData()
    }
    func addCaloriesToAll() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .caloriesAdded, object: nil)
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
            
            
            NotificationCenter.default.post(name: .caloriesAdded, object: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return calorieController.calories.count
        return fetchedResultsController.fetchedObjects?.count ?? 0
//        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieAmount", for: indexPath)
        
//        let tracker = calorieController.calories[indexPath.row]
        let tracker = fetchedResultsController.object(at: indexPath)
        
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

extension CalorieTrackerViewController: NSFetchedResultsControllerDelegate {
  
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
        switch type {
            
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
           
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            let indexSet = IndexSet(integer: sectionIndex)
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            let indexSet = IndexSet(integer: sectionIndex)
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
