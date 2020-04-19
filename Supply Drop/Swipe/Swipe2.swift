//
//  Swipe2.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Swipe2: View {
    var body: some View {
        VStack {
            TabView {
                Text("The First Tab")
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("First")
                    }
                Text("Another Tab")
                    .tabItem {
                        Circle()
                        Image(systemName: "2.square.fill")
                        Text("Second")
                    }
                Text("The Last Tab")
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("Third")
                    }
            }
        }
    }
}

struct Swipe2_Previews: PreviewProvider {
    static var previews: some View {
        Swipe2()
    }
}
