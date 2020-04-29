//
//  Profile.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Profile: View {
    @State var presentMe:Bool = false
    @State var previous:Int
    @State var back:Bool = false
    
    @EnvironmentObject var loggedIn:Bools
    @EnvironmentObject var user:User
    
    var body: some View {
        GeometryReader{geometry in
            VStack {
                ZStack {
                    ZStack {
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
                            .frame(maxWidth:geometry.size.width/3,maxHeight:geometry.size.width/2.5)
                            .offset(y:geometry.size.height/8)
                            .edgesIgnoringSafeArea(.top)
                    }.edgesIgnoringSafeArea(.top)
                    
                   Button(action: {
                       self.back = true
                   }){
                       HStack {
                           Image(systemName: "chevron.left")
                            Text("Back")
                       }
                       .foregroundColor(Color.white)
                   }
                   .position(x:50,y:geometry.size.height/8)
                    .edgesIgnoringSafeArea(.top)
                }
                .edgesIgnoringSafeArea(.top)
                
                Spacer()
                
                VStack(spacing:20) {
                    Spacer()
                    
                    Text("Profile")
                        .font(.largeTitle)
                        .padding(.top,geometry.size.height/10)
                        .frame(width:300)
                    
                    Text("Name: \(self.user.name)")
                        .frame(width:300)
                    
                    Text("Username: \(self.user.username)")
                    .frame(width:300)
                    
                    Text("Email: \(self.user.email)")
                        .frame(width:300)
                    
                    Text("Address: \(self.user.initAddress.getLoc())")
                        .frame(width:300,height:100,alignment: .top)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom,20)

                VStack {
                    NavigationLink(destination:Edit_Profile( previous: self.previous)){
                        Text("Edit Your Profile")
                        .foregroundColor(Color.purple)
                    }
                    
                    NavigationLink(destination:ContentView(),isActive: self.$presentMe){EmptyView()}
                    
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "LoggedIn")
                        UserDefaults.standard.set(nil, forKey: "Token")
                        self.loggedIn.setBools(value: false)
                    }) {
                        Text("Sign Out")
                            .foregroundColor(Color.red)
                            .padding(.bottom,50)
                            .padding(.top,30)
                    }
                    
                    if(self.previous==0){
                        NavigationLink(destination:Donations(),isActive: self.$back){EmptyView()}
                    } else{
                        NavigationLink(destination:Request_Form(order: Request()),isActive: self.$back){EmptyView()}
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea([.top])
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(previous: 0).environmentObject(User())
    }
}
