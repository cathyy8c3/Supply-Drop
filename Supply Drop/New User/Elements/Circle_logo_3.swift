//
//  Circle_logo_3.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Circle_logo_3: View {
    var body: some View {
        Image("logo")
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
        .shadow(radius: 20)
        .frame(minWidth: 100, idealWidth: 175,maxWidth: 175, minHeight: 100, idealHeight: 175, maxHeight: 175)

    }
}

struct Circle_logo_3_Previews: PreviewProvider {
    static var previews: some View {
        Circle_logo_3()
    }
}
