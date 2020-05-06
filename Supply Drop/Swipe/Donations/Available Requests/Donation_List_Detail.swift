//
//  Donation_List_Detail.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Donation_List_Detail: View {
    @State var claim:String = "Claim Request"
    @State var message:String = ""
    @State var manager:Api = Api()
    
    @EnvironmentObject  var user:User
    
    @ObservedObject  var order:Request
    
    var body: some View {
        GeometryReader{geometry in
            VStack {
                VStack {
                    ZStack {
                        MapView(address: self.order.addressString.toAddress(address: self.order.addressString).getLoc())
                            .edgesIgnoringSafeArea([.top])
                            .frame(minHeight:geometry.size.height/6,idealHeight:geometry.size.height/6, maxHeight:geometry.size.height/6)
                    }
                    
                    User().profile
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode:.fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .overlay(Circle().stroke(Color.white,lineWidth: 2))
                        .frame(idealWidth: 100, maxWidth:150)
                        .offset(y:-150)
                        .padding(.bottom,-200)
                }
                
                ScrollView{
                    VStack(spacing:20) {
                        Text("Request")
                            .font(.largeTitle)
                            .padding(.top,30)
                        
                        Text("Made by \(self.order.requesterUsername)")
                        
                        Text("Asking for \(String(self.order.num)) \(self.order.item)")
                        
                        VStack {
                            Text("Address: \(self.order.addressString.toAddress(address: self.order.addressString).getLoc())")
                                .frame(width:300,height:90,alignment: .top)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,20)
                    }
                    
                    Spacer()

                    Button(action: {
                        if(self.order.donorID == -1){
                            self.order.setDonor(u:self.user)
                            self.order.claimed = true
                            self.claim = "Claimed"
                            self.order.status = 1
                            
                            self.order.setDonor(u: self.user)
                            self.manager.updateRequest(order: self.order)
                        } else{
                            self.order.setDonor(u:User())
                            self.order.claimed = false
                            self.claim = "Claim Request"
                            self.order.status = 0
                            
                            self.order.setDonor(u: User())
                            self.manager.updateRequest(order: self.order)
                        }
                    }) {
                        if(self.order.donorID == -1){
                            Text("Claim Request")
                                .font(.body)
                                .padding(10)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        } else{
                            Text("Claimed")
                                .font(.body)
                                .padding(10)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom,70)
                }
                
                Spacer()
            }
        }
    }
}

struct Donation_List_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Donation_List_Detail(order: Request()).environmentObject(User())
    }
}
