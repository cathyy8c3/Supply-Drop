//
//  ContentView.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        Your_Request_Details(order: Order())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Bools())
    }
}
