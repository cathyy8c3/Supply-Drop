//
//  MenuContent.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct MenuContent: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            List{
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.purple)
                        .font(.headline)
                }
                .padding(.vertical,15)
                .padding(.top,50)

                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                    Text("Messages")
                        .foregroundColor(.purple)
                        .font(.headline)
                }
                    .padding(.vertical, 15)

                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                    Text("Settings")
                        .foregroundColor(.purple)
                        .font(.headline)
                }
                .padding(.vertical, 15)
                
                
                HStack {
                    Image(systemName: "return")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                    Text("Sign Out")
                        .foregroundColor(.purple)
                        .font(.headline)
                }
                .padding(.vertical,15)
            }
        }
    }
}

struct MenuContent_Previews: PreviewProvider {
    static var previews: some View {
        MenuContent()
    }
}
