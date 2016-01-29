//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Ilia Tikhomirov on 29/01/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //First, you access the managedObjectContext
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveContact(sender: AnyObject) {
        
        //Second, you access the entity from the data model
        
        let entityDescription =
        NSEntityDescription.entityForName("Contact",
            inManagedObjectContext: managedObjectContext)
        
        //Third, using default initializer you assign context and entity
        let contact = Contact(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        //Next, you assign properties
        contact.name = name.text
        contact.address = address.text
        contact.phone = phone.text
        
        //Saving using pre-written Method from AppDelegate
        do {
            
                try managedObjectContext.save()
            
                //Should be executed after
            
                name.text = ""
                address.text = ""
                phone.text = ""
                status.text = "Contact Saved"
            
        } catch {
            
            //Error Handling 
            
            status.text = "Saving Error"
        }
        
        
    }

    @IBAction func findContact(sender: AnyObject) {
        
        //Entery description - can be shared
        
        let entityDescription =
        NSEntityDescription.entityForName("Contact",
            inManagedObjectContext: managedObjectContext)
        
        //Create request and assign the entity
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        //Use a filter to find a specific data point
        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred
            

        //Execute search request which returns the object or nil
                var objects = try! managedObjectContext.executeFetchRequest(request)
     
            //Parse the array of resuts [AnyObject]
                if objects.count > 0 {
                    
                    let match = objects[0] as! NSManagedObject
                    
                    name.text = match.valueForKey("name") as? String
                    address.text = match.valueForKey("address") as? String
                    phone.text = match.valueForKey("phone") as? String
                    
                    status.text = "Matches found: \(objects.count)"
                    
                } else {
                    status.text = "No Match"
                }

        
        
        
    }
}

