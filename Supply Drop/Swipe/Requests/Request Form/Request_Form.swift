//
//  Request_Form.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_Form: View {
    @State var showPopUp = false
    
    @ObservedObject var viewRouter = MainTabBarData(initialIndex: 0, customItemIndex1: 2,customItemIndex2: 3)
    @ObservedObject  var order:Request
    
    @EnvironmentObject var user:User
    
    var body: some View {
        NavigationView{
            VStack {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        if self.viewRouter.itemSelected == 1 {
                            Request_List()
                        } else if self.viewRouter.itemSelected == 0 {
                            Request_Form_1(order1: self.order)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            if self.showPopUp {
                                HStack(spacing: 50) {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(Color(red: 0.55, green: 0, blue: 0.8, opacity: 0.8))
                                            .frame(width: 70, height: 70)
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(20)
                                            .frame(width: 70, height: 70)
                                            .foregroundColor(.white)
                                    }
                                    .onTapGesture {
                                        self.viewRouter.itemSelected = 2
                                    }
                                }
                                .transition(.scale)
                                .offset(y: -geometry.size.height/6)
                            }
                            
                            HStack {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                                    .frame(width: geometry.size.width/3, height: 75)
                                    .foregroundColor(self.viewRouter.itemSelected == 0 ? Color(red: 0.55, green: 0, blue: 0.8, opacity: 1) : .gray)
                                    .onTapGesture {
                                        self.viewRouter.itemSelected = 0
                                    }
                                
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.white)
                                        .frame(width: 75, height: 75)
                                    
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode:.fit)
                                        .padding()
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.55, green: 0, blue: 0.8, opacity: 0.3), Color(red: 0.55, green: 0, blue: 0.8, opacity: 1)]), startPoint: .top, endPoint: .bottom))
                                        .clipShape(Circle())
                                        .shadow(radius: 20)
                                        .frame(width: 75, height: 75)
                                        .foregroundColor(.white)
                                        .rotationEffect(Angle(degrees: self.showPopUp ? 90 : 0))
                                }
                                .offset(y: -geometry.size.height/10/2)
                                .onTapGesture {
                                    withAnimation {
                                       self.showPopUp.toggle()
                                    }
                                }
                                
                                NavigationLink(destination:Profile(previous: 1), isActive:self.$viewRouter.isCustomItemSelected1){EmptyView()}
                                
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                                    .frame(width: geometry.size.width/3, height: 75)
                                    .foregroundColor(self.viewRouter.itemSelected == 1 ? Color(red: 0.55, green: 0, blue: 0.8, opacity: 1) : .gray)
                                    .onTapGesture {
                                        self.viewRouter.itemSelected = 1
                                    }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height/10)
                            .background(Color.white.shadow(radius: 2))
                        }
                    }
                    .edgesIgnoringSafeArea([.bottom])
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct Request_Form_Previews: PreviewProvider {
    static var previews: some View {
        Request_Form(order: Request()).environmentObject(User())
    }
}
