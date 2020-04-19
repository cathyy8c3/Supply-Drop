//
//  Sign_In.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Sign_In: View {
    @State var showView = false
    
    var body: some View {

        NavigationView{
            VStack (spacing:15){
                NavigationLink(destination:signIn()){
                    Text("Sign In")
                        .font(.largeTitle)
                }
                
                NavigationLink(destination:newUser(user: User())){
                    Text("Don't have an account? Sign up here.")
                        .font(.subheadline)
                }
                
                NavigationLink(destination: googleSignIn()){
                Image("google_login")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200)
                }
            }
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
        }
        .frame(minWidth: 500, idealWidth: 500,maxWidth: 500, minHeight: 150, idealHeight: 150, maxHeight: 150)
    

        
//        .resizable()
//        .scaledToFit()
    }
    
}

struct Sign_In_Previews: PreviewProvider {
    static var previews: some View {
        Sign_In()
    }
}
