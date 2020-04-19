//
//  CustomTabBar.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewRouter = ViewRouter()
        
    @State var showPopUp = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if self.viewRouter.currentView == 0 {
                    Text("Home")
                } else if self.viewRouter.currentView == 1 {
                    Text("Settings")
                }
                Spacer()
                ZStack {
                    if self.showPopUp {
                        PlusMenu(profile: false, messages: false)
                        .offset(y: -geometry.size.height/6)
                    }
                    HStack {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: geometry.size.width/3, height: 75)
                            .foregroundColor(self.viewRouter.currentView == 0 ? Color(red: 0.55, green: 0, blue: 0.8, opacity: 1) : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = 0
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
                                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.55, green: 0, blue: 0.8, opacity: 0.25), Color(red: 0.55, green: 0, blue: 0.8, opacity: 1)]), startPoint: .top, endPoint: .bottom))
                                .clipShape(Circle())
                                .shadow(radius: 15)
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
                            .foregroundColor(self.viewRouter.currentView == 1 ? .black : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = 1
                            }
                    }
                        .frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(Color.white.shadow(radius: 2))
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

struct PlusMenu: View {
    @State var profile:Bool
    @State var messages:Bool
    
    var body: some View {
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
                self.profile=true
            }

            ZStack {
                Circle()
                    .foregroundColor(Color(red: 0.55, green: 0, blue: 0.8, opacity: 0.8))
                    .frame(width: 70, height: 70)
                Image(systemName: "message.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                self.messages=true
            }
        }
            .transition(.scale)
    }
}
