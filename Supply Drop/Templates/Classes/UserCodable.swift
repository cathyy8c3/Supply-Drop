//
//  UserCodable.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/18/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserCodable:Codable{
    var ID:String = ""
    var Username:String = ""
    var Password:String = ""
    var Email:String = ""
    var ShippingAddress:String = ""
    var Name:String = ""
    
    func toUser()->User{
        let convert:User = User()
        
        convert.email = Email
        convert.password = Password
        convert.id = ID
        convert.name = Name
        convert.address = ShippingAddress
        convert.username = Username
        
        return convert
    }
}
