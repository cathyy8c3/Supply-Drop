//
//  Active.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Active: View {
    @EnvironmentObject var user:User

    var body: some View {
        GeometryReader { geometry in
            List {
                Selection(order: Request(),phrase: "is requesting", you:false)
                    .frame(width:geometry.size.width,height:200)
                    .padding(.leading,-20)
            }
        }
    }
}

struct Active_Previews: PreviewProvider {
    static var previews: some View {
        Active().environmentObject(User())
    }
}
