//
//  Your_Request_Details.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Your_Request_Details: View {
    @ObservedObject  var order:Order
    @State  var received:Bool = false
    
    var body: some View {
        NavigationView{
        
            GeometryReader{geometry in
                //ScrollView{
                    VStack {
                        
                        VStack {
                            MapView()
                                .edgesIgnoringSafeArea([.top])
                                .frame(height:geometry.size.height/4)
                            
                            self.order.getDonor().profile
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode:.fit)
                                .clipShape(Circle())
                                .shadow(radius: 20)
                                .overlay(Circle().stroke(Color.white,lineWidth: 2))
                                .frame(idealWidth: 200, maxWidth:500)
                                .offset(y:-170)
                                .padding(.bottom,-150)
                        }
                        
                        Spacer()
                        
                        VStack(spacing:20) {
                            VStack {
                                Text("Your Request")
                                    .font(.title)
                                    .padding(5)
                                
                                NavigationLink(destination:Edit_Your_Request(order: self.order, n: self.order.num)){
                                    Text("Edit Your Request")
                                        .font(.body)
                                        .foregroundColor(Color.purple)
                                }
                            }
                            
                            Text("Claimed by \(self.order.getDonor().username)\(self.order.org2string())")
    //                            .font(.title)
                            
                            Text("You requested \(String(self.order.num)) \(self.order.item).")
    //                            .font(.title)
                            
                            VStack {
                                Text("Address: \(self.order.address.getLoc())")
                                    .frame(width:300,height:100,alignment: .top)
                            }
                            .padding(.bottom,20)
                        }
                        
                        HStack {
                            Toggle(isOn:self.$received) {
                                Text("Received")
                            }
                            .frame(width:130)
                            
                            Button(action: {
                            }) {
                                if(self.received){
                                    Text("Status: Received")
                                        .foregroundColor(Color.black)
                                }
                                else{
                                    Text("Status: Not Received")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            .padding(.leading,40)
                            .frame(alignment:.trailing)
                        }
                        .frame(width:geometry.size.width/1.5)
                        .padding(.bottom,10)
                        
                        Button(action: {
                            if(self.received){
                                self.order.status=2
                            }
                        }) {
                            Text("Update Status")
                                .foregroundColor(Color.purple)
                        }
                        .padding(.bottom,10)
                        
                        Spacer()

                        Button(action: {
                            //todo
                        }) {
                            if(self.order.getDonor().messaging){
                                Text("Send a Message to \(self.order.getDonor().name)")
                                    .font(.body)
                                    .padding(10)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.bottom,70)
                        
                        Spacer()
                    }
                //}
                //.frame(height:geometry.size.height)
            }
//            .navigationBarTitle("")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Your_Request_Details_Previews: PreviewProvider {
    static var previews: some View {
        Your_Request_Details(order: Order())
    }
}
