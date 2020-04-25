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
    
    func validDate(date:String)->Bool{
        let curr = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: curr)
        let month = calendar.component(.month, from: curr)
        let day = calendar.component(.day, from: curr)
        
        let regEx = #"^(((0?[1-9]|1[012])/(0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])/(29|30)|(0?[13578]|1[02])/31)/(19|[2-9]\d)\d{2}|0?2/29/((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00)))$"#
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        if(pred.evaluate(with: date)){
            let date2 = date.split(separator: "/")
            
            if(Int(String(date2[2])) ?? -1>year){
                return true
            } else if(Int(String(date2[2])) ?? -1 == year){
                if(Int(String(date2[0])) ?? -1>month){
                    return true
                } else if(Int(String(date2[0])) ?? -1 == month){
                    if(Int(String(date2[1])) ?? -1>day){
                        return true
                    } else{
                        return false
                    }
                } else{
                    return false
                }
            } else{
                return false
            }
        } else{
            return false
        }
    }
    
    var body: some View {
        GeometryReader{geometry in
            VStack {
                VStack {
                    ZStack {
                        MapView(address: self.order.addressString.toAddress(address: self.order.addressString).getLoc())
                            .edgesIgnoringSafeArea([.top])
                            .frame(minHeight:geometry.size.height/6,idealHeight:geometry.size.height/6, maxHeight:geometry.size.height/6)
                    }
                    
                    self.order.getRequester().profile
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode:.fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .overlay(Circle().stroke(Color.white,lineWidth: 2))
                        .frame(idealWidth: 100, maxWidth:150)
                        .offset(y:-150)
                        .padding(.bottom,-120)
                }
                
                ScrollView{
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
                        
                        if(self.order.donorID != -1){
                            Text("Claimed by \(self.order.getDonor().username)")
                        }
                        
                        Text("You requested \(String(self.order.num)) \(self.order.item).")
                        
                        if(self.order.donorID != -1){
                            Text("Contact the donor at \(self.order.donor.email).")
                                .frame(width:geometry.size.width/1.5, height:70)
                                .multilineTextAlignment(.center)
                        }
                        
                        VStack {
                            Text("Address: \(self.order.address.getLoc())")
                                .frame(width:300,height:90,alignment: .top)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    VStack (spacing:10){
                        if(self.order.status>0 && self.validDate(date: self.order.expectedArrival)){
                            Text("Expected Arrival Date: \(self.order.expectedArrival)")
                        }
                        
                        HStack {
                            if(self.order.status>0){
                                Toggle(isOn:self.$received) {
                                    Text("Received")
                                }
                                .frame(width:130)
                            }
                            
                            if(self.received){
                                Text("Status: Received")
                                    .foregroundColor(Color.black)
                            } else{
                                Text("Status: Not Received")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(width:geometry.size.width/1.5)
                        .padding(.bottom,10)
                    }
                    
                    Button(action: {
                        if(self.order.status < 2){
                            self.order.status=2
                            self.manager.updateRequest(order: self.order)
                        } else{
                            if(self.order.donorID != -1){
                                self.order.status = 1
                            } else{
                                self.order.status = 0
                            }
                            self.manager.updateRequest(order: self.order)
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
                            .padding(.bottom,120)
                    }
                    .actionSheet(isPresented: self.$showingSheet) {
                        ActionSheet(title: Text("Cancel Request"), message: Text("Are you sure you want to cancel your request?"), buttons: [.destructive(Text("Cancel Request")){
                            self.manager.deleteRequest(order: self.order)
                            }, .cancel()])
                    }.padding(.bottom,20)
                }
                
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
