//
//  Welcome.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.ultraLight)
                .shadow(radius: 7)


            
            Text("Upgrade the way you aid.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
