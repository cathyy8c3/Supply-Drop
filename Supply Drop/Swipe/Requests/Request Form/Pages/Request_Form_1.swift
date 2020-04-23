//
//  Request_Form_3.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_Form_1: View {
    @State var order:Request = Request()
    @State var n:Int = 0
    @State var next:Bool = false
    @State var error:String = ""
    
    @EnvironmentObject var user:User
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @ObservedObject  var order1:Request
    
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
            VStack {
                GeometryReader { geometry in
                    ScrollView {
                        Spacer()
                        
                        VStack (spacing: 20){
                            Spacer()
                            
                            Circle_logo_3()
                                .padding([.leading, .trailing],150)
                                .padding(.bottom,20)
                            
                            Text("Make a Request")
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
                                
                            HStack {
                                TextField("*Amazon Link to Item", text: self.$order.org_name)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)
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
                            }
                            
                            HStack {
                                Text("*Date Needed:")
                                    .frame(width:150)
                                
                                TextField("MM/DD/YYYY", text: self.$order.date)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2-150, height:50)
                                    .border(Color.gray, width:0.5)
                            }
                            
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
                                    if(self.order.item.count==0 || self.n==0 || self.order.date.count==0 || self.user.initAddress.address1.count==0 || self.user.initAddress.city.count==0 || self.user.initAddress.state.count==0 || self.user.initAddress.zip.count==0 || self.user.initAddress.country.count==0 || self.order.org_name==""){
                                        self.error = "Please enter all of the required information."
                                    } else if(!self.validDate(date: self.order.date)){
                                        self.error = "Invalid date."
                                    } else if(!self.user.initAddress.validAddress()){
                                        self.error = "Invalid address."
                                    } else{
                                        self.order.address = self.user.initAddress
                                        self.order.num=self.n
                                        self.order1.setOrder2Order(order2: self.order)
                                        self.next=true
                                    }
                                }){
                                    Text("Submit")
                                        .font(.title)
                                        .foregroundColor(Color.purple)
                                        .padding(.bottom, 50)
                                }
                                .frame(width:500)
                                
                                NavigationLink(destination: Request_Form_2(order:self.order1),isActive: self.$next){EmptyView()}
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
}

struct Request_Form_1_Previews: PreviewProvider {
    static var previews: some View {
        Request_Form_1(order1: Request()).environmentObject(User())
    }
}
