//
//  ViewController.swift
//  ToDoList
//
//  Created by Cyril Garcia on 9/28/18.
//  Copyright © 2018 Cyril Garcia. All rights reserved.
//

import UIKit
import CoreDataBC

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var myTableView: UITableView!
    
//    Tasks is the entity name, ToDoList is the xcDataModelID name
    private let coreData = CoreDataBC("Tasks", "ToDoList")
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        Setup the TableView
        self.setupTableView()
        
//        Retrieve our data regardless if we have any or not.
        self.coreData.retrieveData()
    }
    
    @objc private func addTask() {
        let ac = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        ac.addTextField { (textField) in
            textField.placeholder = "Task"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
//            Get the task from our textField
            let task = ac.textFields![0].text!
            
//            Set the task attribute to the task variable, and set the status to
//            a blank string to indicate that it is incomplete
            self.coreData.pushSingleValue(["task": task, "status": ""])
 
//            Reload the TableView
            self.myTableView.reloadData()
        }
        
        ac.addAction(save)
        ac.addAction(cancel)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    private func addButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.addTask))
        self.navigationItem.rightBarButtonItem = button
    }

    private func setupTableView() {
        let navHeight = UIApplication.shared.statusBarFrame.height
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        
        
        self.myTableView = UITableView(frame: CGRect(x: 0, y: navHeight, width: viewWidth, height: viewHeight - navHeight), style: .plain)
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTableView.backgroundColor = UIColor.white
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.view.addSubview(self.myTableView)
        
        self.addButton()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (_,_,_) in
            // Get Data as an NSManagedObject
            let task = self.coreData.getData()[indexPath.row]
            // Delete the task
            self.coreData.delete(task)
            // Reload the TableView
            self.myTableView.reloadData()
        }
        
        delete.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let done = UIContextualAction(style: .normal, title: "Done") { (_, _, _) in
            // Get the task to update
            let task = self.coreData.getData()[indexPath.row]
            // Pass the task as a reference of what to update and set the status attribute to Done as our new value
            self.coreData.update(task, newValues: ["status": "Done"])
            // Reload our TableView
            self.myTableView.reloadData()
        }
        
        done.backgroundColor = UIColor.green
        return UISwipeActionsConfiguration(actions: [done])
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Get the number of items
        return self.coreData.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
//        Get the task
        let task = self.coreData.getData()[indexPath.row]
        
//        Display the task with the attribute called task in our TextLabel
        cell.textLabel?.text = task.value(forKey: "task") as? String
        
//        Display the status with the attribute called status in our detailedTextlabel
        cell.detailTextLabel?.text = task.value(forKey: "status") as? String
        
        return cell
    }

    
}

