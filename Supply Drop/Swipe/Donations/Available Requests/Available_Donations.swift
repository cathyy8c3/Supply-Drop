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
    @EnvironmentObject var user:User
    @State var page: Int = 0
//    @State var data:Array = Array(0..<10)
    @EnvironmentObject var orders:Orders

    var body: some View {
        NavigationView{
            GeometryReader { proxy in
                ZStack {
                    Text("")
                    
                    VStack {
                        Spacer()
                        
                        Pager(page: self.$page,
                              data: Array(0..<self.orders.orders.count),
                              id: \.self) {
                                self.pageView($0)
                                    .frame(width:proxy.size.width/1.1,height:proxy.size.height/4.5)
                        }
                        .vertical()
                        .itemSpacing(-proxy.size.height/20)
//                        .itemSpacing(proxy.size.height/4-proxy.size.height/3)
                        .interactive(0.8)
//                            .rotation3D()
                        .itemAspectRatio(1.5,alignment: .center)
                        .padding(.horizontal)
                        .frame(width: proxy.size.width,
                               height: proxy.size.height/2.1)
                        .edgesIgnoringSafeArea(.bottom)
                            .offset(y:proxy.size.height/4)
                        
                        
                        
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
                        .frame(width: proxy.size.width*2,
                               height: proxy.size.height/1.7)
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
                    
//                    Spacer()
                }
            }
//                .navigationBarTitle("")
            .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func pageView(_ page: Int) -> some View {
        NavigationLink(destination: Donation_List_Detail(order:orders.orders[page])) {
            
            GeometryReader{geometry in
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.08)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .frame(maxWidth: geometry.size.width/1.2, maxHeight:100)
                    
                    Text("Page: \(page)")
                        .fontWeight(.light)
                        .foregroundColor(Color.black)
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
