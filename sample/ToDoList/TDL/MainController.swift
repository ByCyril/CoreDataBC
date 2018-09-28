//
//  MainTableViewController.swift
//  TDL
//
//  Created by Cyril Garcia on 9/27/18.
//  Copyright © 2018 Cyril Garcia. All rights reserved.
//

import UIKit
import CoreData
import CoreDataBC

class MainController: UIViewController {
    
    private var mainView: MainView!
    private var coreData: CoreDataBC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        The Entity name is List
//        The XCDataModelID is TDL
        self.coreData = CoreDataBC("Tasks", "TDL")
        
//        Retrieve the data
        self.coreData.retrieveData()
        
//        Setting up the TableView
        self.mainView = MainView(self)
        
    }
    
//    Prompt the user with an AlertController with a textField to enter a task.
    @objc func addTask() {
        let ac = UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)
        
        ac.addTextField { (textField) in
            textField.placeholder = "Task"
        }
        
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            let task = ac.textFields![0].text!
            self.coreData.pushSingleValue(["task": task, "status": ""])
            self.mainView.reloadTableView()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(save)
        ac.addAction(cancel)
        
        self.present(ac, animated: true, completion: nil)
    }
   
//    Deleting specific task
    @objc func deleteTask(_ task: NSManagedObject) {
        self.coreData.delete(task)
        
    }
    
//    Removes all records
    @objc func removeAllTasks() {
        self.coreData.deleteAll()
        self.mainView.reloadTableView()
    }
    
//    Updating status to done
    @objc func doneTask(_ task: NSManagedObject) {
        self.coreData.update(task, newValues: ["status": "Done"])
    }
    
//    Getting number of records
    @objc func getDataCount() -> Int {
        return self.coreData.getData().count
    }
    
//    Get a specific record
    @objc func getData(_ indexPath: Int) -> NSManagedObject {
        return self.coreData.getData()[indexPath]
    }
    
}
