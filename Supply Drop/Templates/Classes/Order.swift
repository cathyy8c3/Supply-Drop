//
//  Order.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Order:ObservableObject{
    @Published var org_name: String = ""
    @Published var item: String = ""
    @Published var num: Int = 0
    @Published var date:String = ""
    
    @Published var address:Address = Address()
    
    @Published var requester:User = User()
    @Published var donor:User = User()
    @Published var claimed:Bool = false
    
    //todo
    let id = UUID().uuidString
    
    //0 = not sent, 1 = sent, 2 = received
    @Published var status:Int = 0
    @Published var complete:Bool = false
    
    func valid(n:Int)->Bool{
        if(item.count==0 || n==0 || !(date.count==10)){
            return false
        }
        return true
    }
    
    func getRequester()->User{
        //todo
        
        return requester
    }
    
    func getDonor()->User{
        //todo
        
        return donor
    }
    
    func setRequester(u:User){
        //todo
        
        requester=u
    }
    
    func setDonor(u:User){
        //todo
        
        donor=u
    }
    
    func status2string()->String{
        if(status==0){
            return("Not Sent")
        }else if(status==1){
            return("Sent")
        }
        else if(status>=2){
            return("Received")
        }
        return ""
    }
    
    func isSent()->Bool{
        if(status==0){
            return false
        }else{
            return true
        }
    }
    
    func org2string()->String{
        if(org_name==""){
            return ""
        }else{
            return " from \(org_name)"
        }
    }
}

