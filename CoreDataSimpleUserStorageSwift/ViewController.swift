//
//  ViewController.swift
//  CoreDataSimpleUserStorageSwift
//
//  Created by Victor Rosas on 10/8/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var users: [NSManagedObject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.value(forKey: "name") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(users[indexPath.row])
        //Show popup with details
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //loadData()
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //We need NSManagedObjectContext so we check for it
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // NSFetchRequest is responsible for fetching from Core Data.Fetches are like queries
        //in this case we fetch with all objects of entityName
        //We expect return type NSManagedObject
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        //Managed Object Context executes the query
        //Returns array of NSManagedObjects with the criteria of fetch request
        
        do{
            users = try managedContext.fetch(fetchRequest)
        }catch let error as NSError {
            print("Could not fetch \(error),\(error.userInfo)")
        }
        
    }
    
    func loadData(){
        //This will load from Core Data
        //names = ["A","B","C"];
    }

    @IBAction func addUser(_ sender: Any) {
        //Add user in Core Data
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else{
                    return
            }
            
            self.save(name:nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true)
        
    }
    
    func save(name: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //we need NSManagedObjectContext insert to context,then commit to disk
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a new managed object and insert into managed object context
        //you can do in one step using entity(forEntityName: in:)
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //NSManagedObject set name using key-value
        
        person.setValue(name, forKey: "name")
        
        //Commit changes and save to disk using save,insert into array so it can show
        
        do{
            try managedContext.save()
            users.append(person)
        }catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
}

