//
//  Profile.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var user:User
    @State var presentMe:Bool = false
    @EnvironmentObject var loggedIn:Bools
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                //ScrollView{
                    VStack {
//                        Spacer()
                        
                        VStack {
                            Rectangle()
                                .foregroundColor(Color(red: 0.55, green: 0, blue: 0.8, opacity: 0.8))
                                .edgesIgnoringSafeArea([.top])
                                .frame(minHeight:geometry.size.height/3,idealHeight:geometry.size.height/2.5, maxHeight:geometry.size.height/2.5)
                            
                            self.user.profile
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode:.fit)
                                .clipShape(Circle())
                                .shadow(radius: 20)
                                .overlay(Circle().stroke(Color.white,lineWidth: 2))
                                .frame(width:geometry.size.width/2,height:geometry.size.width/2)
                                .offset(y:-geometry.size.height/5)
                                .padding(.bottom,-geometry.size.height/5)
                        }
                        
//                        Spacer()
                        
                        VStack(spacing:20) {
                            Text("Profile")
                                .font(.largeTitle)
                                .padding(.top,10)
                                .frame(width:300)
                            
                            Text("Name: \(self.user.name)")
                                .frame(width:300)
                            
                            Text("Email: \(self.user.email)")
                                .frame(width:300)
                        
                            Toggle(isOn:self.$user.messaging) {
                                Text("Allow Messages:")
                            }
                            .frame(width:210)
                        }
                        .padding(.bottom,20)
                        .padding(.top,50)
                        
//                        Spacer()
                        
                        VStack {
                            NavigationLink(destination:Edit_Profile()){
                                Text("Edit Your Profile")
                                .foregroundColor(Color.purple)
                            }
                            .padding(.bottom,10)
                            
                            NavigationLink(destination: signIn(), isActive: self.$presentMe) { EmptyView() }
                            
                            Button(action: {
                                //todo
                                self.loggedIn.setBools(value: false)
                                
                                self.presentMe = true
                            }) {
                                Text("Sign Out")
                                .foregroundColor(Color.purple)
                                .padding(.bottom, 20)
                            }
                        }
                        
                        Spacer()
                    }
                    .edgesIgnoringSafeArea([.top])
                //}
                //.frame(height:geometry.size.height)
            }
            .edgesIgnoringSafeArea([.top])
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().environmentObject(User()).environmentObject(Bools())
    }
}
