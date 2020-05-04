//
//  passwordReset.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/26/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct passwordReset: View {
    @State var submit:Bool = false
    @State var code:String = ""
    @State var send:Int = 0
    @State var manager:Api = Api()
    @State var back2:Bool = false
    @State var temp:User = User()
    @State var validEmail:Bool = true
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationLink(destination: signIn(), isActive: self.$back2){
                EmptyView()
            }
            
            ZStack {
                Button(action: {
                    self.back2 = true
                }){
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(Color.purple)
                }
                .position(x:50,y:geometry.size.height/10)
                .edgesIgnoringSafeArea(.top)
                
                VStack (alignment: .center, spacing:15){
                    Spacer()
                    
                    Text("Password Reset")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .shadow(radius: 10)
                    
                    TextField("Enter your email.", text: self.$temp.email)
                        .padding()
                        .frame(width:300, height:50)
                        .border(Color.gray, width:0.5)
                    
                    Text(self.send > 0 ? "Email has been sent." : self.validEmail ? "" : "Email not found.")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundColor(Color.red)
                    
                    if(self.send > 0){
                        Text(!self.submit ? "Enter the 9 character code sent to your email:": "Enter your new password.")
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .frame(width:geometry.size.width/1.2)
                            .transition(.scale)
                    }
                    
                    if(!self.submit){
                        VStack (spacing: 10){
                            if(self.send > 0){
                                TextField("ABCDE12345", text: self.$code)
                                    .padding(15)
                                    .frame(width:300, height:50, alignment: .center)
                                    .border(Color.gray, width:0.5)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 36))
                            }
                            
                            Button(action: {
                                self.manager.resetPassword(user1: self.temp) { (reset) in
                                    if(reset.message.count > 17){
                                        self.send = self.send + 1
                                    } else{
                                        self.validEmail = false
                                    }
                                }
                            }) {
                                Text(self.send==0 ? "Send email." : "Resend email.")
                                    .foregroundColor(Color.purple)
                                    .fontWeight(.light)
                                    .font(.body)
                            }
                        }

                        Button(action: {
                            withAnimation{
                                self.submit = true
                            }
                        }) {
                            Text(self.send>0 ? "Submit" : "")
                                .foregroundColor(Color.purple)
                        }
                    }
                    
                    if(self.submit){
                        VStack{
                            withAnimation{
                                passwordReset_2(temp:resetUser(email: self.temp.email, resTok: self.code, newPass: ""))
                            }
                        }
                        .transition(.scale)
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct passwordReset_Previews: PreviewProvider {
    static var previews: some View {
        passwordReset()
    }
}
