//
//  Sign_Up_Button.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Sign_Up_Button: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination:newUser()){
                Text("Don't have an account? Sign up here.")
                .font(.subheadline)
            }
        }
    }
}

struct Sign_Up_Button_Previews: PreviewProvider {
    static var previews: some View {
        Sign_Up_Button()
    }
}
