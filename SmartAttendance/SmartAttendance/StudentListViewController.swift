//
//  studentListViewController.swift
//  SmartAttendance
//
//  Created by Hung Nguyen on 10/30/18.
//  Copyright © 2018 Hung Nguyen. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var studentList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addStudentTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Student", message: nil, preferredStyle: .alert)
        alert.addTextField { (studentListTF) in
            studentListTF.placeholder = "Enter name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let student = alert.textFields?.first?.text else { return }
            print(student)
            self.studentList.append(student)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stuCell = UITableViewCell()
        let student = studentList[indexPath.row]
        stuCell.textLabel?.text = student
        
        return stuCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let subject = studentList[indexPath.row]
        studentList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
//        PersistenceService.context.delete(subject)
//        PersistenceService.saveContext()
//        
//        let fetchRequest: NSFetchRequest<Class> = Class.fetchRequest()
//        do {
//            let classList = try PersistenceService.context.fetch(fetchRequest)
//            self.classList = classList
//        } catch {}
//        self.tableView.reloadData()
        print("Delete \(subject)")
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
