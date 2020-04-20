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

class Request:ObservableObject,Codable,Identifiable{
    @Published var org_name: String = ""
    @Published var item: String = ""
    @Published var num: Int = 0
    @Published var date:String = ""
    
    @Published var address:Address = Address()
    @Published var addressString:String = ""
    
    @Published var requesterID:String = ""
    @Published var donorID:String = ""
    
    @Published var requester:User = User()
    @Published var donor:User = User()
    @Published var claimed:Bool = false
    
    var id = UUID().uuidString
    
    init(){}
    
    //0 = not sent, 1 = sent, 2 = received
    @Published var status:Int = 0
    @Published var complete:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case org_name = "Title"
        case item = "Item"
        case num = "AffiliateLinks"
        case addressString = "ShippingAddress"
        case date = "Description"
        case id = "ID"
        case status = "State"
        case requesterID = "Requester"
        case donorID = "Donor"
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        org_name = try values.decode(String.self, forKey: .org_name)
        item = try values.decode(String.self, forKey: .item)
        num = try values.decode(Int.self, forKey: .num)
        addressString = try values.decode(String.self, forKey: .addressString)
        date = try values.decode(String.self, forKey: .date)
        id = try values.decode(String.self, forKey: .id)
        status = try values.decode(Int.self, forKey: .status)
        requesterID = try values.decode(String.self, forKey: .requesterID)
        donorID = try values.decode(String.self, forKey: .donorID)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(org_name, forKey: .org_name)
        try container.encode(item, forKey: .item)
        try container.encode(num, forKey: .num)
        try container.encode(addressString, forKey: .addressString)
        try container.encode(date, forKey: .date)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
        try container.encode(requesterID, forKey: .requesterID)
        try container.encode(donorID, forKey: .donorID)
    }
    
    func setOrder2Order(order2:Request){
        org_name = order2.org_name
        item = order2.item
        num = order2.num
        date = order2.date
        address = order2.address
    }
    
    func setOrder(item2:String){
        item = item2
    }
    
    func getItem()->String{
        return item
    }
    
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
        requesterID = u.id
    }
    
    func setDonor(u:User){
        //todo
        
        donor=u
        donorID = u.id
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

extension Api{
    func getOrder(completion: @escaping(Request,Bool) -> ()){
        guard let url = URL(string: "https://reqres.in/api/") else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if(error==nil && !(data==nil)){
                do{
                    
                    let order1 = try!JSONDecoder().decode(Request.self, from: data!)
                    
                    if(type(of:data)==String.self){
                        completion(order1,false)
                    }
                    
                    completion(order1,true)
                }
                
                catch{
                    print("Error in JSON parsing.")
                }
            }else{
                print("Error")
                return
            }
        }.resume()
    }
}
