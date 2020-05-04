//
//  passwordReset_2.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/26/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct passwordReset_2: View {
    @State var pass1:String = ""
    @State var pass2:String = ""
    @State var error:String = ""
    @State var temp:resetUser
    @State var manager:Api = Api()
    
    @EnvironmentObject var user:User
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    var body: some View {
        VStack (spacing: 10){
            SecureField("Enter your new password.", text: self.$pass1)
                .padding()
                .frame(width:300, height:50)
                .border(Color.gray, width:0.5)
                
            SecureField ("Enter your new password again.",text: self.$pass2)
                .padding()
                .frame(width:300, height:50)
                .border(Color.gray, width:0.5)
            
            Button(action: {
                if(self.pass1 != self.pass2){
                    self.error = "Passwords don't match."
                } else if(!self.isValidPassword(testStr: self.pass1)){
                    self.error = "Invalid password.\nPassword must have at least 1 uppercase character, 1 lowercase character, 1 digit, and be at least 8 characters."
                } else{
                    self.temp.setPass(newPass: self.pass1)
                    self.manager.resetPassword2(user1: self.temp) { (works) in
                        self.error = works
                    }
                }
            }) {
                Text("Reset Your Password")
                    .foregroundColor(Color.purple)
                    .fontWeight(.light)
            }
            
            Text(self.error)
                .fontWeight(.light)
                .frame(width:300,height: 150)
                .foregroundColor(Color.red)
                .multilineTextAlignment(.center)
        }
    }
}

struct passwordReset_2_Previews: PreviewProvider {
    static var previews: some View {
        passwordReset_2(temp: resetUser(email: "cathy.chang@warriorlife.net", resTok: "ABCDE1234", newPass: ""))
    }
}
