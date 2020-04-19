//
//  Donation_List_Detail.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Donation_List_Detail: View {
    @ObservedObject  var order:Order
    @EnvironmentObject  var user:User
    @State  var claim:String = "Claim Request"
    @State  var message:String = ""
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                //ScrollView{
                    VStack {
                        
                        VStack {
                            ZStack {
                                MapView()
                                    .edgesIgnoringSafeArea([.top])
                                    .frame(minHeight:geometry.size.height/3,idealHeight:geometry.size.height/3, maxHeight:geometry.size.height/3)
                            }
                            
                            self.order.getRequester().profile
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode:.fit)
                                .clipShape(Circle())
                                .shadow(radius: 20)
                                .overlay(Circle().stroke(Color.white,lineWidth: 2))
                                .frame(idealWidth: 200, maxWidth:500)
                                .offset(y:-100)
                                .padding(.bottom,-130)
                        }
                        
                        Spacer()
                        
                        VStack(spacing:20) {
                            Text("Request")
                                .font(.largeTitle)
                                .padding(.top,70)
                            
                            Text("Made by \(self.order.getRequester().username)\(self.order.org2string())")
    //                            .font(.title)
                            
                            Text("Asking for \(String(self.order.num)) \(self.order.item)")
    //                            .font(.title)
                            
                            VStack {
                                Text("Address: \(self.order.address.address1)")
                                    
                                
                                Text("\(self.order.address.address2)")
                                
                                Text("\(self.order.address.city), \(self.order.address.state), \(self.order.address.zip)")
                                
                                Text("\(self.order.address.country)")
                            }
                            .padding(.bottom,20)
                        }
                        
                        Spacer()

                        Button(action: {
                            if(self.order.claimed==false){
                                self.order.setDonor(u:self.user)
                                self.order.claimed = true
                                self.claim = "Claimed"
                            }else{
                                self.order.setDonor(u:User())
                                self.order.claimed = false
                                self.claim = "Claim Request"
                            }
                            //add / remove from user donation list
                            //todo
                        }) {
                            Text("\(self.claim)")
                                .font(.body)
                                .padding(10)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom,70)
                        
                        Spacer()
                    }
                //}
                //.frame(height:geometry.size.height)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Donation_List_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Donation_List_Detail(order: Order()).environmentObject(User())
    }
}
