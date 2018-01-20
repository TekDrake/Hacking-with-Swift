//
//  Move .swift
//  Project34
//
//  Created by Juan Garcia on 1/20/18.
//  Copyright © 2018 Juan Garcia. All rights reserved.
//

import GameplayKit
import UIKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int
    
    init(column: Int) {
        self.column = column
    }
}
