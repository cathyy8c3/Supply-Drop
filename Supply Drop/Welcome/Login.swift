//
//  ContentView.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State var isModal: Bool = false
    @State var toSignIn:Bool = false
    @State var toSwipe:Bool = false
    @State var manager:Api = Api()
    
    @EnvironmentObject var user:User
    @EnvironmentObject var orders:Orders
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Background_Hands()
                        .edgesIgnoringSafeArea([.top,.leading,.trailing])
                    Circle_Logo()
                        .edgesIgnoringSafeArea([.top,.leading,.trailing])
                        .padding([.leading, .trailing],500)
                        .padding(.bottom,100)
                }
                
                Spacer()
                 
                VStack {
                    Welcome()
                        .padding()
                    
                    VStack{
                        Button(action:{
                            if(UserDefaults.standard.bool(forKey: "LoggedIn")){
                                self.manager.getUser2() { (user3, work) in
                                    if (work){
                                        self.user.tempUser2User(user2: user3[0])
                                        self.toSwipe = true
                                    } else{
                                        self.toSignIn = true
                                    }
                                }
                            } else{
                                self.toSignIn = true
                            }
                        }){
                            Text("Sign In")
                                .font(.largeTitle)
                                .foregroundColor(Color.purple)
                        }
                        
                        NavigationLink(destination:signIn(),isActive: self.$toSignIn){
                            EmptyView()
                        }
                        
                        NavigationLink(destination:Swipe(currentPage: 1),isActive: self.$toSwipe){
                            EmptyView()
                        }
                        
                        NavigationLink(destination:newUser(user: User())){
                            Text("Don't have an account? Sign up here.")
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                        }
                        
//                        Button(action:{
//                            self.isModal = true
//                        }){
//                            Image("google_login")
//                                .renderingMode(.original)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width:200)
//                        }.sheet(isPresented: $isModal, content: {
//                            googleSignIn()
//                        })
                    }
                    .frame(minWidth: 500, idealWidth: 500,maxWidth: 500, minHeight: 150, idealHeight: 150, maxHeight: 150)
                }
        
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
