//
//  Claimed_Donations.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Claimed_Donations: View {
    @State var completed:Int = 0
    
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
            .navigationBarTitle("Your Donations")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())

            
    }
}


struct Claimed_Donations_Previews: PreviewProvider {
    static var previews: some View {
        Claimed_Donations()
    }
}
