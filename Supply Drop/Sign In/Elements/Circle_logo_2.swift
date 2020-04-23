//
//  Circle_logo_2.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Circle_logo_2: View {
    var body: some View {
        GeometryReader{geometry in
            Image("logo_circle")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .shadow(radius: 20)
                .frame(width:geometry.size.width/3,height:geometry.size.width/3)
        }
    }
}

struct Circle_logo_2_Previews: PreviewProvider {
    static var previews: some View {
        Circle_logo_2()
    }
}
