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
        return "\(address1)\n\(address2)\n\(city), \(state) \(zip)\n\(country)"
    }
    
    func valid()->String{
        if(address1.count==0 || city.count==0 || state.count==0 || state.count==0 || zip.count==0 || country.count==0){
            return "Please enter information into all fields."
        }
        
        return ""
    }
}
