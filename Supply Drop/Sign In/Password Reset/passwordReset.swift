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
    
    @EnvironmentObject var user:User
    
    var body: some View {
        GeometryReader{ geometry in
            VStack (alignment: .center, spacing:20){
                Spacer()
                
                Text("Password Reset")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .shadow(radius: 10)
                
                Text(!self.submit ? "Enter the 9 character code sent to your email:": "Enter your new password.")
                    .font(.headline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .frame(width:geometry.size.width/1.2)
                    .transition(.scale)
                
                if(!self.submit){
                    VStack (spacing: 10){
                        TextField("ABCDE12345", text: self.$code)
                            .padding(15)
                            .frame(width:300, height:50, alignment: .center)
                            .border(Color.gray, width:0.5)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 36))
                        
                        Button(action: {
                            //todo
                        }) {
                            Text("Resend email.")
                                .foregroundColor(Color.purple)
                                .fontWeight(.light)
                        }
                    }

                    Button(action: {
                        withAnimation{
                            self.submit = true
                        }
                    }) {
                        Text("Submit")
                            .foregroundColor(Color.purple)
                    }
                }
                
                if(self.submit){
                    VStack{
                        withAnimation{
                            passwordReset_2()
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

struct passwordReset_Previews: PreviewProvider {
    static var previews: some View {
        passwordReset()
    }
}
