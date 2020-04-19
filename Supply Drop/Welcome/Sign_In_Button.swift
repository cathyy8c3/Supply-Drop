//
//  Sign_In_Button.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Sign_In_Button: View {
    var body: some View {
        NavigationView{
            
            VStack (spacing:0){
                NavigationLink(destination:signIn()){
                    Text("Sign In")
                        .font(.largeTitle)
                        .padding()
                }
                
                NavigationLink(destination:newUser()){
                    Text("Don't have an account? Sign up here.")
                    .font(.subheadline)
                }
            }
        }
    }
}

struct Sign_In_Button_Previews: PreviewProvider {
    static var previews: some View {
        Sign_In_Button()
    }
}
