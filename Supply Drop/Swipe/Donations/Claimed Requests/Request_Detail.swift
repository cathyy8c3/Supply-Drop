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
    @State var sent:Bool = false
    @State private var showingSheet = false
    @State var manager:Api = Api()
    @State var validDateString:String = ""
    
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
                        MapView(address: self.order.address.getLoc())
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
                        .offset(y:-100)
                        .padding(.bottom,-120)
                        .zIndex(5)
                    
                    NavigationView{
                        VStack (alignment:.center) {
                            HStack {
                                Text("Expected Arrival Date: ")
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                                    .multilineTextAlignment(.center)
                                
                                TextField("MM/DD/YYYY", text: self.$order.expectedArrival)
                                    .padding()
                                    .border(Color.gray, width:0.5)
                                    .padding(.leading,10)
                                    .frame(width:150)
                            }
                            
                            Text(self.validDateString)
                                .foregroundColor(Color.red)
                                .padding(.bottom,10)
                            
                            Button(action: {
                                if(self.validDate(date: self.order.expectedArrival)){
                                    self.order.expectedArrival = self.order.expectedArrival
                                    self.manager.updateRequest(order: self.order)
                                    self.validDateString = "Saved."
                                } else{
                                    self.validDateString = "Invalid date."
                                }
                            }) {
                                Text("Save")
                                    .foregroundColor(Color.purple)
                            }
                        }
                        .frame(width:350, height:150)
                    }
                }
                
                ScrollView{
                    VStack(spacing:10) {
                        Text("Request")
                            .font(.largeTitle)
                                            
                        Text("Made by \(self.order.getRequester().name)")
                        
                        Text("Asking for \(String(self.order.num)) \(self.order.item)")
                        
                        Text("Contact them at \(self.order.requester.email).")
                            .frame(width:geometry.size.width/1.5, height:100)
                            .multilineTextAlignment(.center)
                        
                        VStack {
                            Text("Address: \(self.order.address.getLoc())")
                                .frame(width:300,height:90,alignment: .top)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    HStack {
                        if(self.order.status > 1){
                            Text("Status: Received")
                                .foregroundColor(Color.purple)
                        } else{
                            Text("Status: Not Received")
                            .foregroundColor(Color.purple)
                        }
                    }
                    .frame(width:geometry.size.width/1.5)
                    .padding(.bottom,20)
                    
                    NavigationLink(destination:Claimed_Donations(),isActive: self.$showingSheet){EmptyView()}
                    
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("Cancel Donation")
                            .foregroundColor(Color.red)
                    }
                    .actionSheet(isPresented: self.$showingSheet) {
                        ActionSheet(title: Text("Cancel Donation"), message: Text("Are you sure you want to cancel your donation?"), buttons: [.destructive(Text("Cancel Donation")){
                            self.order.claimed=false
                            self.order.status = 0
                            self.order.setDonor(u:User())
                            self.manager.updateRequest(order: self.order)
                            }, .cancel()])
                    }
                    .padding(.bottom,60)
                }
                
                Spacer()
            }
        }
    }
}

struct Request_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Request_Detail(order: Request())
    }
}
