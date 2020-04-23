//
//  Your_Request_Details.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Your_Request_Details: View {
    @State  var received:Bool = false
    @State var manager:Api = Api()
    @State private var showingSheet = false
    
    @EnvironmentObject var user:User
    
    @ObservedObject  var order:Request
    
    var body: some View {
        GeometryReader{geometry in
            VStack {
                VStack {
                    MapView(address: self.order.address.getLoc())
                        .edgesIgnoringSafeArea([.top])
                        .frame(height:geometry.size.height/4)
                    
                    self.order.getDonor().profile
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode:.fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .overlay(Circle().stroke(Color.white,lineWidth: 2))
                        .frame(idealWidth: 200, maxWidth:300)
                        .offset(y:-100)
                        .padding(.bottom,-70)
                }
                
                Spacer()

                VStack(spacing:20) {
                    VStack {
                        Text("Your Request")
                            .font(.title)
                            .padding(5)
                        
                        NavigationLink(destination:Edit_Your_Request(n: self.order.num, order: self.order)){
                            Text("Edit Your Request")
                                .font(.body)
                                .foregroundColor(Color.purple)
                        }
                    }
                    
                    Text("Claimed by \(self.order.getDonor().username)")
                    
                    Text("You requested \(String(self.order.num)) \(self.order.item).")
                    
                    Text("Contact the donor at \(self.order.donor.email).")
                    
                    VStack {
                        Text("Address: \(self.order.address.getLoc())")
                            .frame(width:300,height:100,alignment: .top)
                            .multilineTextAlignment(.center)
                    }
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
                
                Button(action: {
                    self.showingSheet = true
                }) {
                    Text("Cancel Request")
                        .foregroundColor(Color.red)
                        .padding(.bottom,80)
                }
                .actionSheet(isPresented: self.$showingSheet) {
                    ActionSheet(title: Text("Cancel Request"), message: Text("Are you sure you want to cancel your request?"), buttons: [.destructive(Text("Cancel Request")){
                        //todo
                        //delete request
                        self.manager.deleteRequest(order: self.order)
                        }, .cancel()])
                }.padding(.bottom,20)
                
                Spacer()
            }
        }
    }
}

struct Your_Request_Details_Previews: PreviewProvider {
    static var previews: some View {
        Your_Request_Details(order: Request()).environmentObject(User())
    }
}
