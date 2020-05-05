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
        if("\(address1)\(address2)\(city)\(state)\(zip)\(country)".count == 0){
            return ""
        }
        
        if(address2==""){
            return "\(address1)\n\(city), \(state) \(zip)\n\(country)"
        }
        return "\(address1)\n\(address2)\n\(city), \(state) \(zip)\n\(country)"
    }
    
    func storeLoc()->String{
        return "\(address1),\(address2),\(city),\(state),\(zip),\(country)"
    }
    
    func isValid(completion: @escaping(Bool) -> ()){
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(getLoc()) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let _ = placemarks.first?.location
            else {
                completion(false)
                return
            }
        }
        
        completion(true)
    }
    
    func validAddress()->Bool{
        let works:Bool = true
        
        return works
    }
}
