//
//  Commit+CoreDataClass.swift
//  Project38
//
//  Created by Juan Garcia on 1/31/18.
//  Copyright © 2018 Juan Garcia. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("Init called!")
    }
}
