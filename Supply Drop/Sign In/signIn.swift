//
//  signIn.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct signIn: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isModal: Bool = false
    @State var validUser:Bool = false
    @State var error:String = ""
    
    @EnvironmentObject var user:User
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        NavigationView{
            
            VStack{
                Spacer()
//                GeometryReader{geometry in
//                    Spacer()
                    Circle_logo_2()
                        .frame(maxHeight:300)
                    
//                        .frame()
    //                    .padding([.leading, .trailing],275)
//                }

                Spacer()
                
                VStack (alignment: .center, spacing:20){
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .shadow(radius: 10)
                    
                    VStack (spacing: 10){
                        TextField("Enter your username.", text: $username)
                            .padding()
                            .frame(width:300, height:50)
                            .border(Color.gray, width:0.5)
                            
                        
                        SecureField("Enter your password.",text: $password)
                            .padding()
                            .frame(width:300, height:50)
                            .border(Color.gray, width:0.5)
                        
                        Button(action:{
                            //todo
                        }){
                            Text("Forget your password?")
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                        }
                        
                        NavigationLink(destination:newUser(user: self.user)){
                            Text("Create an account.")
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                        }
                    }
                    
                    NavigationLink(destination:Swipe(),isActive: self.$validUser){EmptyView()}
                    
                    VStack{
                        Text(error)
                            .foregroundColor(Color.red)
                        
                        Button(action:{
                            //todo
                            
                            Api().getUser{user1,exists  in
                                if(exists){
                                    self.user.setUser2User(user2: user1)
                                    
                                    self.validUser=true
                                }else{
                                    self.error = "Incorrect password or username."
                                }
                            }
                        }){
                            Text("Submit")
                                .padding(.top, 10)
                                .font(.title)
                                .foregroundColor(Color.purple)
                        }
                        .frame(width:300)
                        .disabled(username.count==0 || password.count==0)
                        
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
