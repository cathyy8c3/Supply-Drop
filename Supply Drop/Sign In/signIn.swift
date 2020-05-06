//
//  signIn.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import Combine

struct signIn: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isModal: Bool = false
    @State var validUser:Bool = false
    @State var error:String = ""
    
    @EnvironmentObject var orders:Orders
    @EnvironmentObject var user:User
    @EnvironmentObject var loggedIn:Bools
    
    @ObservedObject var manager:Api = Api()
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Circle_logo_2()
                    .frame(maxHeight:300)

                Spacer()
                
                VStack (alignment: .center, spacing:20){
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .shadow(radius: 10)
                    
                    VStack (spacing: 10){
                        TextField("Enter your username.", text: self.$user.username)
                            .padding()
                            .frame(width:300, height:50)
                            .border(Color.gray, width:0.5)
                            
                        
                        SecureField ("Enter your password.",text: self.$user.password)
                            .padding()
                            .frame(width:300, height:50)
                            .border(Color.gray, width:0.5)
                        
                        NavigationLink (destination:passwordReset()){
                            Text("Forgot your password?")
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                        }
                        
                        NavigationLink (destination:newUser(user: self.user)){
                            Text("Create an account.")
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                        }
                    }
                    
                    NavigationLink (destination:Swipe(currentPage: 1),isActive: self.$validUser){EmptyView()}
                    
                    VStack{
                        Text(error)
                            .foregroundColor(Color.red)
                        
                        Button (action:{
                            self.manager.authenticate(user: self.user, completion: { done,user2 in
                                if(done){
                                    self.manager.getUser2(){ (user3, work) in
                                        if (work){
                                            self.user.tempUser2User(user2: user3[0])
                                        }
                                    }
                                    
//                                    self.manager.getAvailable { (order2) in
//                                        self.orders.setOrders2Orders(order1:order2, user1:self.user)
//                                    }
                                    self.loggedIn.setBools(value: true)
                                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                                    UserDefaults.standard.set(user2.string, forKey: "Token")
                                    
                                    self.validUser = true
                                } else{
                                    self.error = "Incorrect username or password."
                                }
                            })
                        }
                        ){
                            Text("Submit")
                                .padding(.top, 10)
                                .font(.title)
                                .foregroundColor(Color.purple)
                        }
                        .frame(width:300)
                        .disabled(self.user.username.count==0 || self.user.password.count==0)
                        
//                        Button(action:{
//                            self.isModal = true
//                        }){
//                            Image("google_login")
//                            .renderingMode(.original)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                                .frame(width:200,height:50)
//                        }.sheet(isPresented: $isModal, content: {
//                            googleSignIn()
//                        })
                    }
                    .frame(height:100)

                }
                .padding(.bottom,50)
                
                Spacer()
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .offset(y: -keyboardResponder.currentHeight*0.9)
    }
}

struct signIn_Previews: PreviewProvider {
    static var previews: some View {
        signIn().environmentObject(User())
    }
}
