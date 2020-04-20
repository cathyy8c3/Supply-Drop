//
//  newUser.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import Foundation

struct newUser: View {
    @State var user:User
    @State var password1:String = ""
    @State var password2:String = ""
    @State var pass:Bool = false
    @State var passError:String = ""
    @State var emailUsernameError:String = ""
    @State var height:CGFloat = 0
    
    @State var manager:Api = Api()
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func isValidUsername(username:String)->Bool{
        return username.isAlphanumeric
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ScrollView {
                    VStack{
                        Spacer()
                        
                        Circle_logo_3()
                            .padding([.leading, .trailing],275)
        //                    .padding(.top,200)
                        
                        VStack (alignment: .center, spacing: 30){
                            Text("Sign Up")
                                .font(.largeTitle)
                                .fontWeight(.thin)
                                .shadow(radius: 10)
                            
                            VStack (spacing: 10){
                                TextField("*Enter your name.", text: self.$user.name)
                                    .padding()
                                .frame(width:300, height:50)
                                .border(Color.gray, width:0.5)
                                
                                TextField("*Enter your email.", text: self.$user.email)
                                    .padding()
                                    .frame(width:300, height:50)
                                    .border(Color.gray, width:0.5)
                                
                                TextField("*Enter your username.", text: self.$user.username)
                                    .padding()
                                    .frame(width:300, height:50)
                                    .border(Color.gray, width:0.5)
                                
                                VStack {
                                    Text(self.emailUsernameError)
                                        .foregroundColor(Color.red)
                                        .padding(.bottom, 20)
                                }
                                
                                SecureField("*Enter your password.",text:self.$password1)
                                    .padding()
                                    .frame(width:300, height:50)
                                    .border(Color.gray, width:0.5)
                                
                                SecureField("*Enter your password again.",text:self.$password2)
                                    .padding()
                                    .frame(width:300, height:50)
                                    .border(Color.gray, width:0.5)
                                
                                
                                Text(self.passError)
                                    .padding(.bottom,20)
                                    .foregroundColor(Color.red)
                                    .multilineTextAlignment(.center)
                                    .frame(width:geometry.size.width/1.2,height:self.height)
                                
                                VStack(spacing:20){
                                    Text("Address")
                                        .font(.body)
                                    
                                    TextField("Address Line 1", text: self.$user.initAddress.address1)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)

                                    
                                    TextField("Address Line 2", text: self.$user.initAddress.address2)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)
                                    
                                    HStack {
                                        TextField("City", text: self.$user.initAddress.city)
                                        .padding()
                                        .frame(width:geometry.size.width/1.2-geometry.size.width/2.3-15, height:50)
                                        .border(Color.gray, width:0.5)
                                        
                                        TextField("State", text: self.$user.initAddress.state)
                                            .padding()
                                            .frame(width:75, height:50)
                                            .border(Color.gray, width:0.5)
                                            
                                        TextField("Zip Code", text: self.$user.initAddress.zip)
                                            .keyboardType(.numberPad)
                                            .padding()
                                            .frame(width:geometry.size.width/2.3-75, height:50)
                                            .border(Color.gray, width:0.5)
                                    }
                                    
                                    TextField("Country", text: self.$user.initAddress.country)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)
                                }.padding(.bottom, 20)
                                    
                                
                            }
                            
                                
                            VStack{
                                Button(action:{
                                    if (!(self.password1==self.password2)){
                                        self.passError = "Passwords don't match."
                                        self.height=30
                                    }else if(!self.isValidPassword(testStr: self.password1) || !self.isValidPassword(testStr: self.password2)){
                                            self.passError = "Invalid password.\nPassword must have at least 1 uppercase character, 1 lowercase character, 1 digit, and be at least 8 characters."
                                        self.height=120
                                    }else{
                                        self.passError = ""
                                        self.height=0
                                    }
                                    
                                    if(!self.isValidEmail(email: self.user.email)){
                                        self.emailUsernameError = "Invalid Email."
                                    }else if(!self.isValidUsername(username: self.user.username)){
                                        self.emailUsernameError = "Invalid Username."
                                    }else{
                                        self.emailUsernameError=""
                                    }
                                    
                                    if(self.passError=="" && self.emailUsernameError==""){
                                        //todo
                                        //submit
                                        
                                        self.user.setAddress(add: self.user.initAddress)
                                        self.user.setPass(pass: self.password1)
                                        
                                        self.manager.createUser(user: self.user)
                                    }
                                }){
                                    Text("Create Your Account")
        //                                        .padding(.top, 10)
                                        .font(.title)
                                        .foregroundColor(Color.purple)
                                }
                                .disabled(self.user.name.count==0 || self.user.name.count==0 || self.password1.count==0 || self.password2.count==0)
        //                                Spacer()
                                
                                Text("or")
                                    .font(.body)
                                    .foregroundColor(Color.gray)
                                
                                Google_Login()
                                    .padding(.bottom,30)
        //                                    .frame(minWidth:0,minHeight:40)
                            }
                                
                                
                    }
        //                .padding(.bottom,300)
                        
                        Spacer()
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .navigationViewStyle(StackNavigationViewStyle())
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .offset(y: -self.keyboardResponder.currentHeight*0.9)
        }
        
    }
            
}

struct newUser_Previews: PreviewProvider {
    static var previews: some View {
        newUser(user: User())
    }
}
