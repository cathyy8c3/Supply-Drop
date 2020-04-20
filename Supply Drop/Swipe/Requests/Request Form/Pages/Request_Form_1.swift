//
//  Request_Form_3.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_Form_1: View {
    @ObservedObject  var order1:Order
    
    @State var order:Order = Order()
    @EnvironmentObject var user:User
    @State var n:Int = 0
    @State var next:Bool = false
    @State var error:String = ""
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    
    func validDate(date:String)->Bool{
        let regEx = #"^(((0?[1-9]|1[012])/(0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])/(29|30)|(0?[13578]|1[02])/31)/(19|[2-9]\d)\d{2}|0?2/29/((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00)))$"#
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: date)
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ScrollView{
                    Spacer()
                    VStack (spacing: 20){
                            Spacer()
                        Circle_logo_3()
                        .padding([.leading, .trailing],150)
                        .padding(.bottom,20)
                        
                        Text("Make a Request")
                            .font(.title)
                            .padding(.bottom,0)
                        
                        
                        TextField("Organization Name (Optional)", text: self.$order.org_name)
                            .padding()
                            .frame(width:geometry.size.width/1.2, height:50)
                            .border(Color.gray, width:0.5)
                            
                        HStack {
                            TextField("*Item and Description", text: self.$order.item)
                                .padding()
                                .frame(width:geometry.size.width/1.2, height:50)
                                .border(Color.gray, width:0.5)
        //                        .padding(.trailing,150)
                        }
                        HStack {
                            Stepper(value: self.$n, in: 0...1000) {
                                Text("*# of Items")
                            }
                            .padding()
                            .frame(width:200, height:80)
                            
                            Text("\(String(self.n))")
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
                            Text("*Date Needed:")
                                .frame(width:150)
                            
                            TextField("MM/DD/YYYY", text: self.$order.date)
                            .padding()
                                .frame(width:geometry.size.width/1.2-150, height:50)
                                .border(Color.gray, width:0.5)
                        }
                        
//                        Divider()
                        
                        VStack (spacing:20){
                            Text("*Address")
                                .font(.callout)
                            
                            TextField("Address Line 1", text: self.$user.initAddress.address1)
                            .padding()
                            .frame(width:geometry.size.width/1.2, height:50)
                            .border(Color.gray, width:0.5)

                            
                            TextField("Address Line 2", text: self.$user.initAddress.address2)
                            .padding()
                            .frame(width:geometry.size.width/1.2, height:50)
                            .border(Color.gray, width:0.5)
                            
                            HStack {
                                TextField("City", text: self.$user.initAddress.city)
                                .padding()
                                .frame(width:geometry.size.width/1.2-geometry.size.width/2.3-15, height:50)
                                .border(Color.gray, width:0.5)
                                
                                TextField("State", text: self.$user.initAddress.state)
                                    .padding()
                                    .frame(width:75, height:50)
                                    .border(Color.gray, width:0.5)
                                    
                                TextField("Zip Code", text: self.$user.initAddress.zip)
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .frame(width:geometry.size.width/2.3-75, height:50)
                                    .border(Color.gray, width:0.5)
                            }
                            
                            TextField("Country", text: self.$user.initAddress.country)
                            .padding()
                            .frame(width:geometry.size.width/1.2, height:50)
                            .border(Color.gray, width:0.5)
                            
                            Text(self.error)
                                .foregroundColor(Color.red)
                                .font(.subheadline)
                            
                            Button(action:{
                                //todo
                                
                                self.order.address.valid()
                                
                                if(self.order.item.count==0 || self.n==0 || self.order.date.count==0 || self.user.initAddress.address1.count==0 || self.user.initAddress.city.count==0 || self.user.initAddress.state.count==0 || self.user.initAddress.zip.count==0 || self.user.initAddress.country.count==0){
                                    self.error = "Please enter all of the required information."
                                }else if(!self.validDate(date: self.order.date)){
                                    self.error = "Invalid date."
                                }else{
                                    self.order.address = self.user.initAddress
                                    self.order.num=self.n
                                    self.order1.setOrder2Order(order2: self.order)
                                    self.next=true
                                }
                            }){
                                Text("Submit")
        //                            .padding(.top, 10)
                                    .font(.title)
                                    .foregroundColor(Color.purple)
                                    .padding(.bottom, 50)
                            }
                            .frame(width:500)
                            
                            NavigationLink(destination: Request_Form_2(order:self.order1),isActive: self.$next){EmptyView()}
                            
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
        .offset(y: -keyboardResponder.currentHeight*0.9)
    }
}

struct Request_Form_1_Previews: PreviewProvider {
    static var previews: some View {
        Request_Form_1(order1: Order()).environmentObject(User())
    }
}
