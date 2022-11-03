//
//  ViewController.swift
//  FinalProject_Jumana
//
//  Created by Jumana Rahman on 12/16/20.
//  Copyright © 2020 Jumana Rahman. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //below is temporary array of strings for tasklist
    var taskListarr = [String]()
    var taskID = [UUID]()
    var weightArr = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //initilaize tableview below
        tableView.delegate = self
        tableView.dataSource = self
        
        //adds button that allows user to add another task //top right
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .plain, target: self, action: #selector(addButtonClicked))
        
        getData()
        
    }

    override func viewWillAppear(_ animated: Bool) {   //table will be updated when add new task
        getData()
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newTask"), object: nil)
        
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //return number of rows in tableview
        let rowNum = taskListarr.count
        
        
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //instance of the class AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FinalProject_Jumana")
        
        request.returnsObjectsAsFaults = false //true if objects from fetch using NSFetchRequest is a fault
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do {
                let results = try context.fetch(request)
                for result in results as! [NSManagedObject]{
                    if let task = result.value(forKey: "task") as? String {
                        if task == taskListarr[indexPath.row] {
                            context.delete(result)
                            taskListarr.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                            do{
                                try context.save()
                            } catch {
                                print("error deleting")
                            }
                            break
                        }
                    }
                    
                }
            } catch {
                print("fail")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //this inserts each task into a cell in the table view
        let cell = TaskCell()
        cell.set(task: taskListarr[indexPath.row], weight: weightArr[indexPath.row])
        //cell.textLabel?.text = taskListarr[indexPath.row]
        return cell
    }
    
    @objc func addButtonClicked() {
           performSegue(withIdentifier: "toSecondViewC", sender: nil)      //did identifier in storyboard to go to second view controller
    }
    
    @objc func getData() {     //will retieve data using a fetch request from coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //instance of the class AppDelegate
               
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FinalProject_Jumana")

        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                self.taskListarr.removeAll(keepingCapacity: false)
                self.taskID.removeAll(keepingCapacity: false)
                self.weightArr.removeAll(keepingCapacity: false)
            }
            for result in results as! [NSManagedObject]{
                if let weight = result.value(forKey: "weight") as? String{
                    weightArr.append(weight)
                    //Array(weightArr.sorted().reversed())  can be used later to reverse weights

                }
                if let task = result.value(forKey: "task") as? String{
                    taskListarr.append(task)
                    
                    //for weightpos in weightArr{
                      //  var weightindex
                    //}
                    
                }
                if let id = result.value(forKey: "id") as? UUID{
                    taskID.append(id)
                }
                
                //refresh tableview
                tableView.reloadData()
            }
        
        }catch{
            print("Something wrong viewcontroller")
        }
      
    }
}


