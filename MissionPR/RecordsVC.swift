//
//  RecordsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/18/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class RecordsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var table: UITableView!
    
    var controller: NSFetchedResultsController<Record_Lift>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        table.dataSource = self
        table.delegate = self

        generateTestData()
        attemptFetch()
        table.reloadData()
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Record_Lift> = Record_Lift.fetchRequest()
        let recordSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [recordSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try self.controller.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func configureCell(cell: RecordCell, indexPath: NSIndexPath) {
        let goal = controller.object(at: indexPath as IndexPath)
        cell.configureCell(goal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            if sectionInfo.numberOfObjects > 0 {
                return sectionInfo.numberOfObjects
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordCell
        configureCell(cell: cell!, indexPath: indexPath as NSIndexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func generateTestData() {
        let record1 = Record_Lift(context: context)
        record1.name = "Flat Bench Press"
        record1.weight = 225
        record1.reps = 10
        
        let record2 = Record_Lift(context: context)
        record2.name = "Shoulder Barbell Press"
        record2.weight = 135
        record2.reps = 10
        
        let record3 = Record_Lift(context: context)
        record3.name = "Squat"
        record3.weight = 275
        record3.reps = 5
        
        ad.saveContext()
    }
    

}
