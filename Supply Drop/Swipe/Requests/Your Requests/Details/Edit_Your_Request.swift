//
//  Edit_Your_Request.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Edit_Your_Request: View {
    @ObservedObject  var order:Request
        @State var n:Int
        @State var presentMe:Bool = false
    @EnvironmentObject var user:User
    @State var manager:Api = Api()
        
        var body: some View {
            NavigationView{
                GeometryReader{ geometry in
                    ScrollView{
                        Spacer()
                        VStack (spacing: 20){
                                Spacer()
                            Circle_logo_3()
                                .padding([.leading, .trailing,],150)
                                .padding(.bottom,20)
                            
                            Text("Request Info")
                                .font(.title)
                                .padding(.bottom,0)
                            
                            
                            TextField("Organization Name (optional)", text: self.$order.org_name)
                                .padding()
                                .frame(width:geometry.size.width/1.2, height:50)
                                .border(Color.gray, width:0.5)
                                
                            HStack {
                                TextField("Item", text: self.$order.item)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)
            //                        .padding(.trailing,150)
                            }
                            HStack {
                                Stepper("# of Items", value: self.$n, in: 0...1000)
                                        .padding()
                                    .frame(width:200, height:80)
                                
                                Text("\(self.n)")
                                    .padding()
                                    .frame(width:geometry.size.width/1.2-205, height:50)
                                    .border(Color.gray, width:0.5)
                        
                                
            //                        TextField("# of Items", text: self.$num)
            //                            .keyboardType(.numberPad)
            //                            .padding()
            //                            .frame(width:150, height:50)
            //                            .border(Color.gray, width:0.5)
                            }
                            
                            HStack {
                                Text("Date Needed:")
                                    .frame(width:150)
                                
                                TextField("MM/DD/YYYY", text: self.$order.date)
                                .padding()
                                    .frame(width:geometry.size.width/1.2-150, height:50)
                                    .border(Color.gray, width:0.5)
                            }
                            
                            Divider()
                            
                            VStack (spacing:20){
                                Text("Address")
                                    .font(.callout)
                                
                                TextField("Address Line 1", text: self.$order.address.address1)
                                .padding()
                                .frame(width:geometry.size.width/1.2, height:50)
                                .border(Color.gray, width:0.5)

                                
                                TextField("Address Line 2", text: self.$order.address.address2)
                                .padding()
                                .frame(width:geometry.size.width/1.2, height:50)
                                .border(Color.gray, width:0.5)
                                
                                HStack {
                                    TextField("City", text: self.$order.address.city)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2-geometry.size.width/2.3-15, height:50)
                                    .border(Color.gray, width:0.5)
                                    
                                    TextField("State", text: self.$order.address.state)
                                        .padding()
                                        .frame(width:75, height:50)
                                        .border(Color.gray, width:0.5)
                                        
                                    TextField("Zip Code", text: self.$order.address.zip)
                                        .keyboardType(.numberPad)
                                        .padding()
                                        .frame(width:geometry.size.width/2.3-75, height:50)
                                        .border(Color.gray, width:0.5)
                                }
                                
                                TextField("Country", text: self.$order.address.country)
                                .padding()
                                .frame(width:geometry.size.width/1.2, height:50)
                                .border(Color.gray, width:0.5)
                                
                                NavigationLink(destination: Your_Request_Details(order:self.order), isActive: self.$presentMe) { EmptyView() }
                                
                                Button(action: {
                                    self.presentMe = true
                                    self.order.num=self.n
                                    
                                    self.user.setAddress(add: self.order.address)
                                    
                                    self.manager.updateUser(user: self.user)
                                    self.manager.updateRequest(order: self.order)
                                }) {
                                    Text("Submit")
                                    .font(.title)
                                    .foregroundColor(Color.purple)
                                    .padding(.bottom, 20)
                                }
                                .frame(width:500)

                                
    //                            NavigationLink(destination:Request_Form_3(order:self.order)){
    //                                Text("Submit")
    //                                    .font(.title)
    //                                    .foregroundColor(Color.purple)
    //                                    .padding(.bottom, 20)
    //                            }
    //                            .frame(width:500)
                            }
                            
                        }
                    }
            //                .frame(maxHeight:1000)
                
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
        }
}

struct Edit_Your_Request_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Your_Request(order: Request(), n: 0)
    }
}
