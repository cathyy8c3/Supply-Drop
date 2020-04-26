//
//  MainView.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/18/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var loggedIn:Bools
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if(UserDefaults.standard.bool(forKey: "LoggedIn")){
                    Login()
                        .transition(.scale)
                } else{
                    Login2()
                        .transition(.scale)
                }
            }
            .onAppear{
                self.loggedIn.setBools(value: UserDefaults.standard.bool(forKey: "LoggedIn"))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
    }
}
