//
//  Request_Form_1.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_Form_3: View {
    @ObservedObject  var order:Request
    @EnvironmentObject var user:User
    @State var next:Bool = false
    
    @State var manager:Api = Api()
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
//                Spacer()
                    ScrollView{
                        Spacer()
                    VStack (spacing: 5){
                        Spacer()
                        Circle_logo_3()
                        .padding([.leading, .trailing],140)
                            .padding(.bottom, 50)
                        
                        Text("Request Summary")
                            .font(.title)
                        
                        NavigationLink(destination:Edit(order: self.order, n: Int(self.order.num) )){
                            Text("Edit Your Request")
                                .font(.body)
                                .foregroundColor(Color.purple)
                        }
                        .frame(width:500)
                        
                        VStack {
                            Text("Item: \(self.order.item)\n\(self.order.description)")
                                .frame(width:geometry.size.width/1.2, height:70, alignment: .topLeading)
                            
                            Text("Amazon Link: \(self.order.org_name)")
                            .frame(width:geometry.size.width/1.2, height:50, alignment: .leading)
                            
                            Text("# of Items: \(self.order.num)")
                            .frame(width:geometry.size.width/1.2, height:50, alignment: .leading)
                            
                            Text("Date Needed: \(self.order.date)")
                            .frame(width:geometry.size.width/1.2, height:50, alignment: .leading)
                        }
                        Spacer()
                        
                        Divider()
                        
                        Spacer()
                        
                        VStack{
                            Text("Address")
                                .font(.callout)
                                .padding()
                            
                            Text("Line 1: \(self.order.address.address1)")
                            .frame(width:geometry.size.width/1.2, height:30, alignment: .leading)
                            
                            Text("Line 2: \(self.order.address.address2)")
                            .frame(width:geometry.size.width/1.2, height:30, alignment: .leading)
                            
                            HStack {
                                Text("City: \(self.order.address.city)")
                                    .frame(width: geometry.size.width/3.6-25, height:50, alignment: .leading)
                                    .padding([.leading,.trailing])
                                
                                Text("State: \(self.order.address.state)")
                                    .frame(width: geometry.size.width/3.6-25, height:50, alignment: .leading)
                                    .padding([.leading,.trailing])
                                
                                Text("Zip Code: \(self.order.address.zip)")
                                    .frame(width: geometry.size.width/3.6-25, height:50, alignment: .leading)
                                    .padding([.leading,.trailing])

                            }
                            
                            Text("Country: \(self.order.address.country)")
                            .frame(width:geometry.size.width/1.2, height:50, alignment: .leading)
                            
                            NavigationLink(destination:Thank_You(),isActive: self.$next){EmptyView()}
                            
                            
                            Button(action:{
                                //todo
                                
                                //send request
                                
                                self.next=true
                                
                                self.order.setRequester(u: self.user)
                                
                                self.order.setNumString()
                                
                                self.order.setAddress()
                                
                                self.manager.createRequest(order: self.order)
                                self.user.setAddress(add:self.user.initAddress)
                                self.manager.updateUser(user: self.user)
                            }){
                                Text("Submit")
        //                            .padding(.top, 10)
                                    .font(.title)
                                    .foregroundColor(Color.purple)
                                    .padding([.bottom], 50)
                                    .padding(.top,10)
                            }
                            .frame(width:500)
                            
                            
                        }
                        
                    }
                        Spacer()
                }
//                    .frame(maxHeight:1000)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .offset(y: -keyboardResponder.currentHeight*0.9)
    }
}

struct Request_Form_3_Previews: PreviewProvider {
    static var previews: some View {
        Request_Form_3(order:Request()).environmentObject(User())
    }
}
