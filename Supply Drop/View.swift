//
//  View.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/18/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct View: View {
    @EnvironmentObject var loggednIn:Bools

    struct ContentView: View {
        var body: some View {
            if(loggedIn.getBools()){
                Swipe()
            }else{
                Login()
            }
        }
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        View()
    }
}
