//
//  User.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class User:Codable, Identifiable, ObservableObject{
    @Published var name:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var username:String = ""
    @Published var address:String = ""
    @Published var id:Int = -1
    
    @Published var initAddress:Address = Address()
    
    @Published var profile:Image = Image("logo_profile")
    @Published var messaging:Bool = true
    
    func tempUser2User(user2:tempUser){
        DispatchQueue.main.async {
            self.name = user2.Name
            self.email = user2.Email
            self.username = user2.Username
            self.address = user2.ShippingAddress
            self.initAddress = user2.ShippingAddress.toAddress(address: user2.ShippingAddress)
            self.id = user2.ID
        }
    }
    
//
//    @Published var requests:[Int] = []
//    @Published var donations:[Int] = []
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case email = "Email"
        case password = "Password"
        case username = "Username"
        case address = "ShippingAddress"
        case id = "ID"
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        password = try values.decode(String.self, forKey: .password)
        username = try values.decode(String.self, forKey: .username)
        address = try values.decode(String.self, forKey: .address)
        id = try values.decode(Int.self, forKey: .id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(username, forKey: .username)
        try container.encode(address, forKey: .address)
        try container.encode(id, forKey: .id)
    }
    
    func validPass()->Bool{
        if(password.count>=8 && password.count<=32){
            return true
        }
        return false
    }
    
    init(){}
    
    func setAddress(add:Address){
        address = add.storeLoc()
    }
    
    func setPass(pass:String){
        password = pass
    }
    
    func setUser(name2:String, email2:String, password2:String, username2:String, address2:String, id2:Int){
        name=name2
        email=email2
        password=password2
        username=username2
        address=address2
        id=id2
    }
    
    func setUser2User(user2:User){
        name = user2.name
        email = user2.email
        password = user2.password
        address = user2.address
        id = user2.id
        username = user2.username
    }
}

struct tempUser:Codable{
    var Name,Username,ShippingAddress,Email:String
    var ID:Int
}

class Api:ObservableObject{
    var authenticated:Bool = false
    
    func authenticate(user:User, completion: @escaping(Bool,[tempUser]) -> ()){
        
        guard let url = URL(string: "http://localhost:1500/api/users/auth") else{
            print("no url")
            return
        }
        
        
        let body:[String:String] = ["Username": user.username, "Password": user.password]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else{
                print("No data.")
                return
            }
            
//            if(type(of: data)==String.self){
//                self.authenticated = false
//
//            }else{
//                self.authenticated = true
//            }

            if let finalData = try? JSONDecoder().decode([tempUser].self, from:data){
                print("working")
                print(finalData)

                self.authenticated = true
                
                completion(true,finalData)
                
            } else{
                print(String(data: data, encoding: .utf8)!)
                print("error")

                self.authenticated = false
                
                completion(false,[])
            }
        }.resume()
    }
    
    func createUser(user:User){
        guard let url = URL(string: "http://localhost:1500/api/users/new") else{
            print("no url")
            return
        }
        
        guard let finalBody = try? JSONEncoder().encode(user) else {
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
    
    func getDonations(id:String,completion: @escaping([Request]) -> ()){
        guard let url = URL(string: "http://localhost:1500/api/users/id/donations") else{
                return
        }
        
        let body:[String:String] = ["ID": id]
        let finalBody = try!JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if(error==nil && !(data==nil)){
                do{
                    let order1 = try!JSONDecoder().decode([Request].self, from: data!)
                    
                    if(type(of:data)==String.self){
                        
                        completion(order1)
                    }
                    
                    completion(order1)
                }
                
//                catch{
//                    print("Error in JSON parsing.")
//                }
            }else{
                print("Error")
                return
            }
        }.resume()
    }
    
    func getRequests(id:String,completion: @escaping([Request]) -> ()){
        guard let url = URL(string: "http://localhost:1500/api/users/id/requests") else{
                return
        }
        
        let body:[String:String] = ["ID": id]
        let finalBody = try!JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if(error==nil && !(data==nil)){
                do{
                    let order1 = try!JSONDecoder().decode([Request].self, from: data!)
                    
                    if(type(of:data)==String.self){
                        
                        completion(order1)
                    }
                    
                    completion(order1)
                }
                
//                catch{
//                    print("Error in JSON parsing.")
//                }
            }else{
                print("Error")
                return
            }
        }.resume()
    }
    
    func updateUser(user:User){
        guard let url = URL(string: "http://localhost:1500/api/users/id/update") else{
            print("no url")
            return
        }
        
        guard let finalBody = try? JSONEncoder().encode(user) else {
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
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func toAddress(address:String)->Address{
        let tempAdd = address.components(separatedBy: "\n")
        
        let finAdd = Address()
        finAdd.address1 = tempAdd[0]
        finAdd.address2 = tempAdd[1]
        finAdd.city = tempAdd[2]
        finAdd.state = tempAdd[3]
        finAdd.zip = tempAdd[4]
        finAdd.country = tempAdd[5]
        
        return finAdd
    }
}
