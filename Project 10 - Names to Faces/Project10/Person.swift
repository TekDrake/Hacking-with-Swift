//
//  Person.swift
//  Project10
//
//  Created by Juan Garcia on 6/21/17.
//  Copyright © 2017 Juan Garcia. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
