//
//  Whistle.swift
//  Project33
//
//  Created by Juan Garcia on 8/9/17.
//  Copyright © 2017 Juan Garcia. All rights reserved.
//

import CloudKit
import UIKit

class Whistle: NSObject {
    var recordID: CKRecordID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
