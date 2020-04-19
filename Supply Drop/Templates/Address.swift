//
//  Address.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import Foundation
import CoreLocation

class Address{
    var address1:String = ""
    var address2:String = ""
    var city:String = ""
    var state:String = ""
    var zip:String = ""
    var country:String = ""
    
    func getLoc()->String{
        return "\(address1) \(address2) \(city) \(state) \(zip) \(country)"
    }
}
