//
//  CustomTabBar.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Donations: View {
    @ObservedObject var viewRouter = MainTabBarData(initialIndex: 1, customItemIndex1: 2,customItemIndex2: 3)
    
    @EnvironmentObject var user:User
        
    @State var showPopUp = false
    @State var profile:Bool = false
    @State var messages:Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    if self.viewRouter.itemSelected == 0 {
                        Claimed_Donations()
//                            .padding(.top,35)
//                        .navigationBarTitle("")
//                        .navigationBarHidden(true)
                    } else if self.viewRouter.itemSelected == 1 {
                        Available_Donations(order: Request())
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

//                                ZStack {
//                                    Circle()
//                                        .foregroundColor(Color(red: 0.55, green: 0, blue: 0.8, opacity: 0.8))
//                                        .frame(width: 70, height: 70)
//                                    Image(systemName: "message.fill")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .padding(20)
//                                        .frame(width: 70, height: 70)
//                                        .foregroundColor(.white)
//                                }
//                                .onTapGesture {
//                                    self.viewRouter.itemSelected = 3
//                                }
                            }
                                .transition(.scale)
                            .offset(y: -geometry.size.height/6)
                        }
                        HStack {
                            Image(systemName: "list.bullet")
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
                            Image(systemName: "magnifyingglass")
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
                    NavigationLink(destination:Profile(previous: 0), isActive:self.$viewRouter.isCustomItemSelected1){EmptyView()}
                }.edgesIgnoringSafeArea([.bottom])
                
                
//                    .sheet(isPresented: self.$viewRouter.isCustomItemSelected1, onDismiss: {
//                    print("dismiss")
//                }) {
//                    Profile().environmentObject(self.user)
//
//                }
            }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
//        .sheet(isPresented: self.$viewRouter.isCustomItemSelected2, onDismiss: {
//                print("dismiss")
//            }) {
//                Text("hello2")
//            }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
//            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Donations_Previews: PreviewProvider {
    static var previews: some View {
        Donations().environmentObject(User())
    }
}
