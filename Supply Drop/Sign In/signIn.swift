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
                                    self.user.tempUser2User(user2: user2[0])
                                    self.manager.getAvailable { (order2) in
                                        self.orders.setOrders2Orders(order1:order2)
                                    }
                                    DispatchQueue.main.async {
                                        for i in (0..<self.orders.orders.count){
                                            if(self.orders.orders[i].donorID ?? -1>=0){
                                                self.manager.getUser(userID: self.orders.orders[i].donorID ?? -1) { (user1) in
                                                    self.orders.orders[i].donor.tempUser22User(user2:user1[0])
                                                }
                                            }
                                            if(self.orders.orders[i].requesterID>=0){
                                                self.manager.getUser(userID: self.orders.orders[i].requesterID ) { (user1) in
                                                    self.orders.orders[i].requester.tempUser22User(user2:user1[0])
                                                }
                                            }
                                        }
                                        self.orders.objectWillChange.send()
                                    }
                                    self.validUser = true
                                }else{
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
                        
                        Button(action:{
                            self.isModal = true
                        }){
                            Image("google_login")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                                .frame(width:200,height:50)
                        }.sheet(isPresented: $isModal, content: {
                            googleSignIn()
                        })
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
