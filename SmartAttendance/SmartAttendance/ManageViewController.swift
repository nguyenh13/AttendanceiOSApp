//
//  ManageClasses.swift
//  SmartAttendance
//
//  Created by Hung Nguyen on 10/12/18.
//  Copyright © 2018 Hung Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ManageViewController : UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var classList = [Class]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if classList.count == 0 {
        createAlert(title: "Add class", message: "Click plus button to add class")
        }
        tableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<Class> = Class.fetchRequest()
        
        do {
            let classList = try PersistenceService.context.fetch(fetchRequest)
            self.classList = classList
            self.tableView.reloadData()
        } catch {}
       
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAddTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Class", message: nil, preferredStyle: .alert)
        alert.addTextField { (classListTF) in
            classListTF.placeholder = "Enter Class"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let list = alert.textFields?.first?.text else { return }
            print(list)
//            self.add(list)
            let subject = Class(context: PersistenceService.context)
            subject.class_name = list
            PersistenceService.saveContext()
            self.classList.append(subject)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return classList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
        
        cell.textLabel?.text = classList[indexPath.row].class_name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        classList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        let subject = classList[indexPath.row]
        PersistenceService.context.delete(subject)
        PersistenceService.saveContext()
        
        let fetchRequest: NSFetchRequest<Class> = Class.fetchRequest()
        do {
            let classList = try PersistenceService.context.fetch(fetchRequest)
            self.classList = classList
        } catch {}
        self.tableView.reloadData()
        print("Delete \(subject)")
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    //Alert function to add class
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true,completion: nil)
    }
    
}

