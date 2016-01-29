//
//  Contact.swift
//  CoreDataDemo
//
//  Created by Ilia Tikhomirov on 29/01/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import CoreData


class Contact: NSManagedObject {    
    
    @NSManaged var address: String?
    @NSManaged var phone: String?
    @NSManaged var name: String?

}
