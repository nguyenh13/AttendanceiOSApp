//
//  ManageClasses.swift
//  SmartAttendance
//
//  Created by Hung Nguyen on 10/12/18.
//  Copyright © 2018 Hung Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ManageViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var classList = [Class]()
    var selectedClass: Class?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Manage Classes"
        tableView.dataSource = self
        
        //fetch data in classList in order show display data everytime the view is loaded.
        let fetchRequest: NSFetchRequest<Class> = Class.fetchRequest()
        do {
            let classList = try PersistenceService.context.fetch(fetchRequest)
            self.classList = classList
            self.tableView.reloadData()
        } catch {}
       
        
        // Do any additional setup after loading the view.
    }
    
    //Add button to add Class cell
    @IBAction func onAddTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Class", message: nil, preferredStyle: .alert)
        alert.addTextField { (classListTF) in
            classListTF.placeholder = "Enter Class"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let list = alert.textFields?.first?.text else { return }
            print(list)
            let subject = Class(context: PersistenceService.context)
            subject.class_name = list
            PersistenceService.saveContext()
            self.classList.append(subject)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //Datasource Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return classList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
        
        cell.textLabel?.text = classList[indexPath.row].class_name
        
        return cell
    }
    
    //Editing function, allows to swipe cell to delete, swipe all the way left to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let subject = classList[indexPath.row]
        classList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        PersistenceService.context.delete(subject)
        PersistenceService.saveContext()
        
        //update data after deleting cell
        let fetchRequest: NSFetchRequest<Class> = Class.fetchRequest()
        do {
            let classList = try PersistenceService.context.fetch(fetchRequest)
            self.classList = classList
        } catch {}
        self.tableView.reloadData()
        print("Delete \(subject)")
    }

    //Select each class row to go to next view for creating student list.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index < classList.count {
            selectedClass = classList[index]
            performSegue(withIdentifier: "studentInfoView", sender: self)
        }
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "studentInfoView" {
//            let destinationVC = segue.destination as! StudentListViewController
//            destinationVC.student = selectedClass
//        }
//    }
}

