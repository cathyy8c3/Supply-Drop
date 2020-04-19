//
//  Google_Login.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Google_Login: View {
    @State var isModal: Bool = false
    @EnvironmentObject var user:User
    
    var body: some View {
        HStack (alignment:.center) {
            Spacer()
            NavigationLink(destination:signIn()){
                Text("Sign In")
                    .font(.body)
                    .foregroundColor(Color.purple)
            }
            
            Spacer()
            
            Button(action:{
                self.isModal = true
            }){
                Image("google_login")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:200)
            }.sheet(isPresented: $isModal, content: {
                googleSignIn()
            })
            
            Spacer()
        }
        .frame(minWidth: 200, idealWidth: 300, maxWidth: 300,minHeight:50, maxHeight: 70)
        .padding([.leading,.trailing],30)
    
    }
}

struct Google_Login_Previews: PreviewProvider {
    static var previews: some View {
        Google_Login()
    }
}
