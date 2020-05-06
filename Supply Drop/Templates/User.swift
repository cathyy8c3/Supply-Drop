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
import JWTDecode

class User:Codable, Identifiable, ObservableObject{
    @Published var name:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var username:String = ""
    @Published var address:String = ""
    @Published var id:Int = -1
    private var reset:String = ""
    
    @Published var initAddress:Address = Address()
    
    @Published var profile:Image = Image("logo_profile")
    @Published var messaging:Bool = true
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case email = "Email"
        case password = "Password"
        case username = "Username"
        case address = "ShippingAddress"
        case id = "ID"
        case reset = "ResetToken"
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        password = try values.decode(String.self, forKey: .password)
        username = try values.decode(String.self, forKey: .username)
        address = try values.decode(String.self, forKey: .address)
        id = try values.decode(Int.self, forKey: .id)
        reset = try values.decode(String.self, forKey: .reset)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(username, forKey: .username)
        try container.encode(address, forKey: .address)
        try container.encode(id, forKey: .id)
        try container.encode(reset, forKey: .reset)
    }
    
    init(){}
    
    func tempUser2User(user2:tempUser){
        DispatchQueue.main.async {
            self.name = user2.Name
            self.email = user2.Email
            self.username = user2.Username
            self.initAddress = user2.ShippingAddress.toAddress(address: user2.ShippingAddress)
            self.address = self.initAddress.getLoc()
            self.id = user2.ID
        }
    }
    
    func tempUser22User(user2:tempUser2){
        DispatchQueue.main.async {
            self.name = user2.Name
            self.email = user2.Email
            self.username = user2.Username
            self.initAddress = user2.ShippingAddress.toAddress(address: user2.ShippingAddress)
            self.address = user2.ShippingAddress
        }
    }
    
    func validPass()->Bool{
        if(password.count>=8 && password.count<=32){
            return true
        }
        return false
    }
    
    func setAddress(add:Address){
        address = add.storeLoc()
    }
    
    func setPass(pass:String){
        password = pass
    }
    
    func setUsername(usern:String){
        username = usern
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

class tempUser:Codable{
    var Name,Username,ShippingAddress,Email:String
    var ID:Int
    
    init(){
        Name = ""
        Username = ""
        ShippingAddress = ""
        Email = ""
        ID = -1
    }
}

class tempUser2:Codable{
    var Name,Username,ShippingAddress,Email:String
}

class tempUser3:Codable{
    var Name,Username,ShippingAddress,Email,token,CurrentPassword,NewPassword:String
    var ID:Int
    
    init(user2:User, tok:String, oldPass:String, newPass:String){
        Name = user2.name
        Username = user2.username
        ShippingAddress = user2.address
        Email = user2.email
        ID = user2.id
        token = tok
        CurrentPassword = oldPass
        NewPassword = newPass
    }
}

class resetUser:Codable,ObservableObject{
    var Email,ResetToken,NewPassword:String
    
    init(email:String, resTok:String, newPass:String){
        Email = email
        ResetToken = resTok
        NewPassword = newPass
    }
    
    func setPass(newPass:String){
        NewPassword = newPass
    }
}

class Token:Codable{
    var token:String = ""
    
    func setToken(tok:String){
        token = tok
    }
}

class Api:ObservableObject{
    var authenticated:Bool = false
    @Published var orders:[Request] = []
    
    //done
    
    func authenticate(user:User, completion: @escaping(Bool,JWT) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/auth") else{
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
            
            print("Authentication: ")
            print(String(data: data, encoding: .utf8)!)
            print("Auth end")
            
            if let data2 = try? decode(jwt: String(data: data, encoding: .utf8)!){
                self.authenticated = true
                
                print("Logged in successfully")
                UserDefaults.standard.set(data2.string, forKey: "Token")
                
                completion(true,data2)
            } else{
                print("Authentication: ")
                print(String(data: data, encoding: .utf8)!)
                print("Auth end")
                self.authenticated = false
            }
        }.resume()
    }
    
    //done
    
    func createUser(user:User, completion: @escaping(String) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/new") else{
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
            
            guard let res = try? String(data: data, encoding: .utf8) else{
                completion("")
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            completion(res)
        }.resume()
    }
    
    //done
    
    func getDonations(userID:Int,completion: @escaping([Request]) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/\(String(userID))/donations") else{
            return
        }
        
        let temp:Token = Token()
        temp.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        let body:[String:String] = ["token":temp.token]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(temp.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            print("Donations:")
            print(String(data: data, encoding: .utf8)!)
            print("End Donations")
            
            let requests = try!JSONDecoder().decode([Request].self, from: data)
            completion(requests)
        }.resume()
    }
    
    //done
    
    func getRequests(userID:Int,completion: @escaping([Request]) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/\(String(userID))/requests") else{
                return
        }
        
        let temp:Token = Token()
        temp.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        let body:[String:String] = ["token":temp.token]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(temp.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            print("Requests:")
            print(String(data: data, encoding: .utf8)!)
            print("End Requests")
            
            let requests = try!JSONDecoder().decode([Request].self, from: data)
            completion(requests)
        }.resume()
    }
    
    //done
    
    func updateUser(user:User, oldPass1:String, newPass1:String){
        guard let url = URL(string: "http://localhost:3306/api/users/\(String(user.id))/update") else{
            print("no url")
            return
        }
        
        let temp:Token = Token()
        temp.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        let temp2:tempUser3 = tempUser3(user2: user, tok: temp.token, oldPass: oldPass1, newPass: newPass1)
        
        guard let finalBody = try? JSONEncoder().encode(temp2) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(temp.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else { return }
            
            print("Update User:")
            print(String(data: data, encoding: .utf8)!)
            print("End Update User")
        }.resume()
    }
    
    //done
    
    func getUser2(completion: @escaping([tempUser], Bool) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/get") else{
            print("no url")
            return
        }
        
        let temp:Token = Token()
        temp.setToken(tok: UserDefaults.standard.string(forKey: "Token") ?? "")
        
        let body:[String:String] = ["token":temp.token]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(temp.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else{
                print("No data.")
                return
            }
            if let user2 = try? JSONDecoder().decode([tempUser].self, from: data){
                DispatchQueue.main.async {
                    completion(user2, true)
                }
            } else{
                print("Get User failed")
                completion([tempUser()],false)
            }
        }.resume()
    }
    
    //done
    
    func resetPassword(user1:User, completion: @escaping(Bool) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/reset/generatetoken") else{
            print("no url")
            return
        }
        
        guard let finalBody = try? JSONEncoder().encode(user1) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else{
                print("No data.")
                return
            }
            
            print("Reset Token 1: ")
            print(String(data: data, encoding: .utf8)!)
            print("Reset Token 1 end")
            
            if(String(data: data, encoding: .utf8)!.count > 17){
                completion(true)
            } else{
                completion(false)
            }
        }.resume()
    }
    
    //done
    
    func resetPassword2(user1:resetUser, completion: @escaping(Bool) -> ()){
        guard let url = URL(string: "http://localhost:3306/api/users/reset/recovertoken") else{
            print("no url")
            return
        }
        
        print("ResetUser: \(user1.ResetToken)")
        print(user1.Email)
        print(user1.NewPassword)
        print("End ResetUser")
        
        guard let finalBody = try? JSONEncoder().encode(user1) else {
            print("Failed to encode user")
            return
        }
        
        print("Final Body Reset User: ")
        print(String(data: finalBody, encoding: .utf8)!)
        print("End Final Body Reset User")
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else{
                print("No data.")
                return
            }
            
            print("Reset 2:")
            print(String(data: data, encoding: .utf8)!)
            print("End Reset 2")
            
            if(String(data: data, encoding: .utf8)! == "Password reset"){
                completion(true)
            } else{
                completion(false)
            }
        }.resume()
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func toAddress(address:String)->Address{
        let tempAdd = address.components(separatedBy: ",")
        
        let finAdd = Address()
        
        if(tempAdd.count==6){
            finAdd.address1 = tempAdd[0]
            finAdd.address2 = tempAdd[1]
            finAdd.city = tempAdd[2]
            finAdd.state = tempAdd[3]
            finAdd.zip = tempAdd[4]
            finAdd.country = tempAdd[5]
        } else{
            finAdd.address1 = address
        }
        
        return finAdd
    }
}
