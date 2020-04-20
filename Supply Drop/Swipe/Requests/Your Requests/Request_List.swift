//
//  Request_List.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_List: View {
    @State var completed:Int = 0
    @State var availableList = [Request]()
        
    var body: some View {
        NavigationView{
            VStack {
                
                Picker(selection: $completed, label: Text("")) {
                    Text("Active").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top,20)
                .padding(.horizontal,25)
                
                if(self.completed==0){
                    Active()
                }else{
                    Completed()
                }
                
                Spacer()
                
                //body
                
                
            }
            .navigationBarTitle("Your Requests")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
            
    }
}

struct Request_List_Previews: PreviewProvider {
    static var previews: some View {
        Request_List()
    }
}
