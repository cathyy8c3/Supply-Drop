//
//  MainTabScene.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct MainTabScene: View {

    @ObservedObject private var tabData = MainTabBarData(initialIndex: 1, customItemIndex: 2)

    var body: some View {
        TabView (selection: $tabData.itemSelected){

        // First Secection
        Text("First Section!")
        .tabItem {
            Image(systemName: "1.square.fill")
            Text("First!")
        }.tag(1)

        // Add Element
        Text("Custom Action")
        .tabItem {
            Image(systemName: "plus.circle")
            Text("Add Item")
        }
        .tag(2)

        // Events
        Text("Second Section!")
        .tabItem {
            Image(systemName: "2.square.fill")
            Text("Second")
        }.tag(3)

        }
        .font(.headline)
        .sheet(isPresented: $tabData.isCustomItemSelected, onDismiss: {
            print("dismiss")
        }) {
            Text("Custom action modal")
        }
    }
}
struct MainTabScene_Previews: PreviewProvider {
    static var previews: some View {
        MainTabScene()
    }
}
