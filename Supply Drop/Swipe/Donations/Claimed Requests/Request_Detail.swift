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
    @State  var sent:Bool = false
    @State private var showingSheet = false
    
    @ObservedObject  var order:Request
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
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
                            .padding(.bottom,-90)
                    }
                    
                    Spacer()
                    
                    VStack(spacing:20) {
                        Text("Request")
                            .font(.largeTitle)
                            .padding(.top,10)
                        
                        Text("Made by \(self.order.getRequester().name)\(self.order.org2string())")
                        
                        Text("Asking for \(String(self.order.num)) \(self.order.item)")
                        
                        Text(self.order.affiliateLink)
                        
                        Text("Contact them at \(self.order.requester.email).")
                        
                        VStack {
                            Text("Address: \(self.order.address.getLoc())")
                                .frame(width:300,height:100,alignment: .top)
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
                            } else{
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
                        } else{
                            if(self.order.status<2){
                                self.order.status=0
                            }
                        }
                    }) {
                        Text("Update Status")
                            .foregroundColor(Color.purple)
                    }
                    
                    NavigationLink("", destination:Claimed_Donations(),isActive: self.$showingSheet)
                    
                    Button(action: {
                        self.showingSheet = true
                        
                        //todo
                        //remove from user donation list
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
                    .padding(.bottom,200)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Request_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Request_Detail(order: Request())
    }
}
