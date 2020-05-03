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

class Orders:ObservableObject,Identifiable{
    @Published var orders:[Request] = []
    
    init(){
        setOrders()
    }
    
    func setOrders2Orders(order1:[Request], user1:User){
        var tempOrders:[Request] = []
        
        for each in order1{
            if(each.requesterID != user1.id){
                tempOrders.append(each)
            }
        }
        
        self.orders = tempOrders
    }
    
    func setOrders(){
        Api().getAvailable {
            self.orders = $0
        }
    }
}

class Request:ObservableObject,Codable,Identifiable{
    @Published var org_name: String = ""
    @Published var item: String = ""
    @Published var description: String = ""
    @Published var num:Int = 0
    @Published var numString:String = ""
    @Published var date:String = ""
    @Published var affiliateLink:String = ""
    @Published var expectedArrival:String = ""
    @Published var requesterUsername:String = ""
    @Published var donorUsername:String = ""
    private var token:String = ""
    
    @Published var address:Address = Address()
    @Published var addressString:String = ""
    
    @Published var requesterID:Int = -1
    @Published var donorID:Int? = -1
    
    @Published var id:Int = -1
    
    @Published var requester:User = User()
    @Published var donor:User = User()
    @Published var claimed:Bool = false
    
    //0 = not sent, 1 = sent, 2 = received
    @Published var status:Int = 0
    @Published var complete:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case org_name = "Links" //
        case item = "Title" //
        case num = "Quantity" //
        case description = "Description"
        case addressString = "ShippingAddress" //
        case date = "DateNeeded" //
        case id = "ID" //
        case status = "State" //
        case requesterID = "RequesterID" //
        case donorID = "DonorID" //
        case affiliateLink = "AffiliateLinks"
        case expectedArrival = "ExpectedArrival"
        case requesterUsername = "RequesterUsername"
        case donorUsername = "DonorUsername"
        case token = "token"
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        org_name = try values.decode(String.self, forKey: .org_name)
        item = try values.decode(String.self, forKey: .item)
        num = try values.decode(Int.self, forKey: .num)
        addressString = try values.decode(String.self, forKey: .addressString)
        date = try values.decode(String.self, forKey: .date)
        id = try values.decode(Int.self, forKey: .id)
        status = try values.decode(Int.self, forKey: .status)
        requesterID = try values.decode(Int.self, forKey: .requesterID)
        donorID = try values.decodeIfPresent(Int.self, forKey: .donorID) ?? -1
        affiliateLink = try values.decode(String.self, forKey: .affiliateLink)
        expectedArrival = try values.decode(String.self, forKey: .expectedArrival)
        requesterUsername = try values.decode(String.self, forKey: .requesterUsername)
        donorUsername = try values.decode(String.self, forKey: .donorUsername)
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
        try container.encode(affiliateLink, forKey: .affiliateLink)
        try container.encode(expectedArrival, forKey: .expectedArrival)
        try container.encode(token, forKey: .token)
    }
    
    func setOrder2Order(order2:Request){
        org_name = order2.org_name
        item = order2.item
        num = order2.num
        date = order2.date
        address = order2.address
        addressString = order2.addressString
        description = order2.description
        affiliateLink = order2.affiliateLink
        id = order2.id
        status = order2.status
        requesterID = order2.requesterID
        donorID = order2.donorID
    }
    
    init(){}
    
    func setNumString(){
        numString = String(num)
    }
    
    func setAddress(){
        addressString = address.storeLoc()
    }
    
    func setAdress(add:Address){
        address = add
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
    
    func setToken(tok:String){
        token = tok
    }
    
    func getRequester()->User{
        return requester
    }
    
    func getDonor()->User{
        return donor
    }
    
    func setRequester(u:User){
        requester=u
        requesterID = u.id
    }
    
    func setDonor(u:User){
        donor=u
        donorID = u.id
    }
    
    func status2string()->String{
        if(status==0){
            return("Not Sent")
        } else if(status==1){
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
        } else{
            return true
        }
    }
    
    func org2string()->String{
        if(org_name==""){
            return ""
        } else{
            return " from \(org_name)"
        }
    }
}

extension Api{
    //done
    
    func getAvailable(completion: @escaping([Request]) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/requests/unfulfilled") else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                print("No data.")
                return
            }
            
//            print("Orders: ")
//            print(String(data: data, encoding: .utf8)!)
            
            guard let orders = try?JSONDecoder().decode([Request].self, from: data) else{
                completion([])
                return
            }
            DispatchQueue.main.async {
                completion(orders)
            }
        }.resume()
    }
    
    //done
    
    func createRequest(order:Request){
        guard let url = URL(string: "http://localhost:3306/api/requests/new") else{
            print("no url")
            return
        }
        
        order.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        guard let finalBody = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
    
    //done
    
    func updateRequest(order:Request){
        guard let url = URL(string: "http://localhost:3306/api/requests/\(order.id)") else{
            print("no url")
            return
        }
        
        order.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        guard let finalBody = try? JSONEncoder().encode(order) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
    
    //done
    
    func deleteRequest(order:Request){
        guard let url = URL(string: "http://localhost:3306/api/requests/\(order.id)") else{
            print("no url")
            return
        }
        
        order.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        guard let finalBody = try? JSONEncoder().encode(order) else {
            print("Failed to encode user")
            return
        }

        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        request.httpBody = finalBody

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else { return }
            print("Canceled:")
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
}
