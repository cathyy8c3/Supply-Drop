//
//  Messaging.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/18/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Messaging: View {
    @EnvironmentObject var user:User
    @ObservedObject var user2:User
    
    @State var type:Int = 0
    
    var body: some View {
        NavigationView{
            VStack {
                
                Picker(selection: $type, label: Text("")) {
                    Text("Donors").tag(0)
                    Text("Requesters").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top,20)
                .padding(.horizontal,25)
                
                if(self.type==0){
                    toDonors()
                }else{
                    toRequesters()
                }
                
                Spacer()
                
                //body
                
                
            }
            .navigationBarTitle("Your Requests")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct Messaging_Previews: PreviewProvider {
    static var previews: some View {
        Messaging( user2: User())
    }
}

struct Message {
    var content: String
    var user: User
}
