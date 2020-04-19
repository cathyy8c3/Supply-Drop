//
//  Circle_Logo.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Circle_Logo: View {
    var body: some View {
        Image("logo_circle")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .shadow(radius: 20)
            .frame(minWidth: 250, idealWidth: 500, minHeight: 250, idealHeight: 500)
            //.padding([.leading,.trailing,.bottom],90)

    }
}

struct Circle_Logo_Previews: PreviewProvider {
    static var previews: some View {
        Circle_Logo()
    }
}
