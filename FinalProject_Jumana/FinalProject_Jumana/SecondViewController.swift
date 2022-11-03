//
//  SecondViewController.swift
//  FinalProject_Jumana
//
//  Created by Jumana Rahman on 12/16/20.
//  Copyright © 2020 Jumana Rahman. All rights reserved.
//

//there is problem when click save
//problem when clcik on text box for weight
//but when exit and open app again, the task is there
//delete button doesn't show up


import UIKit
import CoreData


class SecondViewController: UIViewController {
    
    var task = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //task = taskInput.text!
    }
    
    
    
    @IBOutlet weak var SecVCLabel: UILabel!
    
    
    @IBOutlet weak var taskInput: UITextField!
    
    @IBOutlet weak var weightLabel: UILabel!
    
   
    @IBOutlet weak var weightInput: UITextField!
    
    @IBAction func saveBtn(_ sender: UIButton) {
        //when button clicked, save the task and weight to core data
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //instance of the class AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        //below for task
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "FinalProject_Jumana", into: context) //is an instance of the //FinalProject_Jumana entity in Core Data
        newTask.setValue(UUID(), forKey: "id")      //set id
        
        guard taskInput.text != "" else {
            self.presentAlert(message: "Your Task is Empty!")
            return
        }
        guard weightInput.text != "" else {
            self.presentAlert(message: "Please Enter A Weight!")
            return
        }
        
        newTask.setValue(taskInput.text!, forKey: "task" )    //set the task string
        
        newTask.setValue(weightInput.text!, forKey: "weight" )   //set weight
        
        //print(weightInput.text)   
        
        
        //below if context fails
        do{
            try context.save()
        }catch {
            print("Something Wrong")
        }
        
       
            navigationController?.popViewController(animated: true)
        
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
