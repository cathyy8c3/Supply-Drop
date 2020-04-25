//
//  Available_Donations.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct Available_Donations: View {
    @State var page: Int = 0
    @State var manager:Api = Api()
    
    @EnvironmentObject var user:User
    @EnvironmentObject var orders:Orders

    var body: some View {
        NavigationView{
            GeometryReader { proxy in
                ZStack {
                    VStack {
                        Spacer()
                        
                        if(self.orders.orders.count>0){
                            Pager(page: self.$page,
                                  data: Array(0..<self.orders.orders.count),
                                  id: \.self) {
                                    self.pageView($0)
                                        .frame(width:proxy.size.width/1.1,height:proxy.size.height/4.5)
                            }
                            .vertical()
                            .itemSpacing(-proxy.size.height/20)
                            .interactive(0.8)
                            .itemAspectRatio(1.5,alignment: .center)
                            .padding(.horizontal)
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height/2.1)
                            .edgesIgnoringSafeArea(.bottom)
                            .offset(y:proxy.size.height/4)
                            .onAppear(perform:{
                                self.manager.getAvailable { (order2) in
                                    self.orders.setOrders2Orders(order1:order2, user1:self.user)
                                    
                                    for i in (0..<self.orders.orders.count){
                                        if(self.orders.orders[i].donorID ?? -1>=0){
                                            self.manager.getUser(userID: self.orders.orders[i].donorID ?? -1) { (user1) in
                                                self.orders.orders[i].donor.tempUser22User(user2:user1[0])
                                            }
                                        }
                                        if(self.orders.orders[i].requesterID>=0){
                                            self.manager.getUser(userID: self.orders.orders[i].requesterID ) { (user1) in
                                                self.orders.orders[i].requester.tempUser22User(user2:user1[0])
                                            }
                                        }
                                    }
                                }
                            })
                        } else{
                            Text("There are 0 available requests. Come back later!")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                                .frame(width: proxy.size.width/1.1,
                                       height: proxy.size.height/2.1)
                                .edgesIgnoringSafeArea(.bottom)
                                .offset(y:proxy.size.height/4)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: proxy.size.width*2,
                        height: proxy.size.height)
                        .offset(y:-proxy.size.height/2.2)
                        .opacity(1)
                    
                    Image("change_hands")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width*2, height: proxy.size.height/1.7)
                        .offset(y:-proxy.size.height/2.3)
                        .opacity(0.75)
                        .edgesIgnoringSafeArea(.top)
                    
                    Text("Available Donations")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .shadow(radius: 13)
                        .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.8))
                        .offset(y:-proxy.size.height/25)
                    
                    Text("Scroll Down for More")
                        .fontWeight(.ultraLight)
                        .shadow(radius: 13)
                        .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.8))
                        .offset(y:+proxy.size.height/80)
                }
            }
        }
        .onAppear(perform:{
            self.manager.getAvailable { (order2) in
                self.orders.setOrders2Orders(order1:order2, user1: self.user)
                
                for i in (0..<self.orders.orders.count){
                    if(self.orders.orders[i].donorID ?? -1>=0){
                        self.manager.getUser(userID: self.orders.orders[i].donorID ?? -1) { (user1) in
                            self.orders.orders[i].donor.tempUser22User(user2:user1[0])
                        }
                    }
                    if(self.orders.orders[i].requesterID>=0){
                        self.manager.getUser(userID: self.orders.orders[i].requesterID ) { (user1) in
                            self.orders.orders[i].requester.tempUser22User(user2:user1[0])
                        }
                    }
                }
            }
        })
    }

    func pageView(_ page: Int) -> some View {
        NavigationLink(destination: Donation_List_Detail(order:orders.orders[page])) {
            ZStack {
                if(orders.orders[page].requesterID != user.id){
                    GeometryReader{geometry in
                        ZStack {
                            Rectangle()
                                .fill(Color.gray)
                                .opacity(0.08)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .frame(maxWidth: geometry.size.width/1.2, maxHeight:100)
                            
                            Text("\(self.orders.orders[page].num) \(self.orders.orders[page].item)")
                                .font(.system(size: 40))
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                                .frame(height:80,alignment: .leading)
                                .minimumScaleFactor(0.005)
                                .padding(.leading,-25)
                                .padding(.trailing,-20)
                                .frame(maxWidth:geometry.size.width/1.8)
                        }
                    }
                } else{
                    EmptyView()
                }
            }
        }
    }
}

struct Available_Donations_Previews: PreviewProvider {
    static var previews: some View {
        Available_Donations().environmentObject(User()).environmentObject(Orders())
    }
}
