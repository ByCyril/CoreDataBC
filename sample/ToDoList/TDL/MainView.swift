//
//  MainView.swift
//  TDL
//
//  Created by Cyril Garcia on 9/27/18.
//  Copyright © 2018 Cyril Garcia. All rights reserved.
//

import UIKit

class MainView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var myTableView: UITableView!
    private var vc: MainController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(_ vc: MainController) {
        super.init(frame: vc.view.frame)
        self.vc = vc
        self.tableViewSetup()
        self.addAction()
        self.removeAllAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    private func tableViewSetup() {
        self.backgroundColor = UIColor.white
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.frame.width
        let displayHeight: CGFloat = self.frame.height
        
        self.myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTableView.backgroundColor = UIColor.white
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.addSubview(self.myTableView)

        self.vc.view.addSubview(self)
    
    }
    
    private func addAction() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self.vc, action: #selector(self.vc.addTask))
        self.vc.navigationItem.rightBarButtonItem = addButton
    }
    
    private func removeAllAction() {
        let deleteAll = UIBarButtonItem(title: "Delete All", style: .done, target: self.vc, action: #selector(self.vc.removeAllTasks))
        self.vc.navigationItem.leftBarButtonItem = deleteAll
    }
    
    public func reloadTableView() {
        self.myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let done = UIContextualAction(style: .normal, title: "Done") { (action, view, (Bool) -> Void) in
            let task = self.vc.getData(indexPath.row)
            self.vc.doneTask(task)
            self.reloadTableView()
        }
        
        done.backgroundColor = UIColor.orange
        let config = UISwipeActionsConfiguration(actions: [done])
        
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, (Bool) -> Void) in
            let task = self.vc.getData(indexPath.row)
            self.vc.deleteTask(task)
            self.reloadTableView()
        }
        
        delete.backgroundColor = UIColor.red
        let config = UISwipeActionsConfiguration(actions: [delete])
        return config
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vc.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let object = self.vc.getData(indexPath.row)
        cell.textLabel?.text = object.value(forKey: "task") as? String
        cell.detailTextLabel?.text = object.value(forKey: "status") as? String
        return cell
    }

}

