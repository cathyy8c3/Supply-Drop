//
//  Background_Hands.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Background_Hands: View {
    var body: some View {
        Image("hands")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 400, idealWidth: 1600, minHeight: 400, idealHeight: 1600, alignment: .center)
            .opacity(0.6)
    }
}

struct Background_Hands_Previews: PreviewProvider {
    static var previews: some View {
        Background_Hands()
    }
}
