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
    
    @EnvironmentObject var user:User
    
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
                    
                        NavigationLink(destination:signIn()){
                            Text("Sign In")
                                .font(.largeTitle)
                                .foregroundColor(Color.purple)
                        }
                        
                        NavigationLink(destination:newUser(user: User())){
                            Text("Don't have an account? Sign up here.")
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                        }
                        
                        Button(action:{
                            self.isModal = true
                        }){
                            Image("google_login")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:200)
                        }.sheet(isPresented: $isModal, content: {
                            googleSignIn()
                        })
                    }
                    .frame(minWidth: 500, idealWidth: 500,maxWidth: 500, minHeight: 150, idealHeight: 150, maxHeight: 150)
                }
        
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
