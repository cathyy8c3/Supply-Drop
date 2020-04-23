//
//  Edit.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Edit: View {
    @State var n:Int
    @State var presentMe:Bool = false
    @State var error:String = ""
    @State var manager:Api = Api()
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
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
                        
                        TextField("*Item", text: self.$order.item)
                            .padding()
                            .frame(width:geometry.size.width/1.2, height:50)
                            .border(Color.gray, width:0.5)
                        
                        TextField("Description", text: self.$order.description)
                        .padding()
                        .frame(width:geometry.size.width/1.2, height:50)
                        .border(Color.gray, width:0.5)
                            
                        TextField("*Amazon Link", text: self.$order.org_name)
                            .padding()
                            .frame(width:geometry.size.width/1.2, height:50)
                            .border(Color.gray, width:0.5)
                        
                        HStack {
                            Stepper("*# of Items", value: self.$n, in: 0...1000)
                                    .padding()
                                .frame(width:200, height:80)
                            
                            Text("\(self.n)")
                                .padding()
                                .frame(width:geometry.size.width/1.2-205, height:50)
                                .border(Color.gray, width:0.5)
                        }
                        
                        HStack {
                            Text("*Date Needed:")
                                .frame(width:150)
                            
                            TextField("MM/DD/YYYY", text: self.$order.date)
                            .padding()
                                .frame(width:geometry.size.width/1.2-150, height:50)
                                .border(Color.gray, width:0.5)
                        }
                        
                        Divider()
                        
                        VStack (spacing:20){
                            Text("*Address")
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
                            
                            Text(self.error)
                                .foregroundColor(Color.red)
                                .font(.subheadline)
                            
                            Button(action: { 
                                if(self.order.item.count==0 || self.n==0 || self.order.date.count==0 || self.order.address.address1.count==0 || self.order.address.city.count==0 || self.order.address.state.count==0 || self.order.address.zip.count==0 || self.order.address.country.count==0 || self.order.org_name.count==0){
                                    self.error = "Please enter all of the required information."
                                } else if(!self.validDate(date: self.order.date)){
                                    self.error = "Invalid date."
                                } else if(!self.order.address.validAddress()){
                                    self.error = "Invalid address."
                                } else{
                                    self.order.num=self.n
                                    self.manager.createRequest(order: self.order)
                                    self.presentMe=true
                                }
                            }) {
                                Text("Submit")
                                    .font(.title)
                                    .foregroundColor(Color.purple)
                                    .padding(.bottom, 20)
                            }
                            .frame(width:500)
                            
                            NavigationLink(destination: Request_Form_3(order:self.order), isActive: self.$presentMe) { EmptyView() }
                        }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .offset(y: -keyboardResponder.currentHeight*0.9)
    }
}

struct Edit_Previews: PreviewProvider {
    static var previews: some View {
        Edit(n: 0, order: Request())
    }
}
