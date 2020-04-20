//
//  Request_Detail.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import MapKit

struct Request_Detail: View {
    @ObservedObject  var order:Order
    @State  var sent:Bool = false
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                //ScrollView{
                    VStack {
                        
                        VStack {
                            MapView(address: self.order.address.getLoc())
                                .edgesIgnoringSafeArea([.top])
                                .frame(minHeight:geometry.size.height/3,idealHeight:geometry.size.height/3, maxHeight:geometry.size.height/3)
                            
                            self.order.getRequester().profile
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode:.fit)
                                .clipShape(Circle())
                                .shadow(radius: 20)
                                .overlay(Circle().stroke(Color.white,lineWidth: 2))
                                .frame(idealWidth: 200, maxWidth:300)
                                .offset(y:-100)
                                .padding(.bottom,-100)
                        }
                        
                        Spacer()
                        
                        VStack(spacing:20) {
                            Text("Request")
                                .font(.largeTitle)
                                .padding(.top,10)
                            
                            Text("Made by \(self.order.getRequester().name)\(self.order.org2string())")
    //                            .font(.title)
                            
                            Text("Asking for \(String(self.order.num)) \(self.order.item)")
    //                            .font(.title)
                            
                            VStack {
                                Text("Address: \(self.order.address.getLoc())")
                            }
                            .padding(.bottom,20)
                        }
                        
                        HStack {
                            Toggle(isOn:self.$sent) {
                                Text("Sent")
                            }
                            .frame(width:100)
                            
                            Button(action: {
                            }) {
                                if(self.sent){
                                    Text("Status: Sent")
                                        .foregroundColor(Color.black)
                                }
                                else{
                                    Text("Status: Not Sent")
                                    .foregroundColor(Color.black)
                                }
                            }
                            .padding(.leading,40)
                            .multilineTextAlignment(.trailing)
                        }
                        .frame(width:geometry.size.width/1.5)
                        .padding(.bottom,10)
                        
                        Button(action: {
                            if(self.sent){
                                if(self.order.status<2){
                                    self.order.status=1
                                }
                            }
                            else{
                                if(self.order.status<2){
                                    self.order.status=0
                                }
                            }
                        }) {
                            Text("Update Status")
                                .foregroundColor(Color.purple)
                        }
                        .padding(.bottom,10)
                        
//                        Spacer()

//                        Button(action: {
//                            //todo
//                        }) {
//                            if(self.order.getRequester().messaging){
//                                Text("Send a Message to \(self.order.getRequester().name)")
//                                    .font(.body)
//                                    .padding(10)
//                                    .background(Color.gray)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(10)
//                            }
//                        }
//                        .padding(.bottom,30)
                        
                        NavigationLink("", destination:Claimed_Donations(),isActive: self.$showingSheet)
                        
                        Button(action: {
                            self.showingSheet = true
                            
                            //remove from user donation list
                            //todo
                        }) {
                            Text("Cancel Donation")
                                .foregroundColor(Color.red)
                        }
                        .actionSheet(isPresented: self.$showingSheet) {
                            ActionSheet(title: Text("Cancel Donation"), message: Text("Are you sure you want to cancel your donation?"), buttons: [.destructive(Text("Cancel Donation")){
                                    //todo: remove donation from user list
                                        
                                self.order.claimed=false
                                self.order.setDonor(u:User())
                                }, .cancel()])
                        }
                        .padding(.bottom,50)
                        
                        
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

struct Request_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Request_Detail(order: Order())
    }
}
