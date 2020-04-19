//
//  Active_Requests.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Active_Requests: View {
    @EnvironmentObject var user:User
    
    var body: some View {
        GeometryReader { geometry in
            List {
                Selection(order: Order(), phrase: "are requesting", you:true)
                    .frame(width:geometry.size.width,height:200)
                    .padding(.leading,-20)
            }
            .onAppear { UITableView.appearance().separatorStyle = .none } .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
        }
    }
}

struct Active_Requests_Previews: PreviewProvider {
    static var previews: some View {
        Active_Requests()
    }
}
