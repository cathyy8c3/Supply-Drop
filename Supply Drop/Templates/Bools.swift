//
//  Bools.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import Foundation
import Combine

class Bools:ObservableObject{
    @Published var boo:Bool = false
    
    func setBools(value:Bool){
        DispatchQueue.main.async {
            self.boo=value
        }
    }
    
    func getBools()->Bool{
        return boo
    }
}
