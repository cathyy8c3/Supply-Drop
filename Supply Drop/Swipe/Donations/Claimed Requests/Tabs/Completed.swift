//
//  Completed.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Completed: View {
    @State var manager:Api = Api()
    @State var donationList:[Request] = []
    
    @EnvironmentObject var user:User
    
    var body: some View {
        GeometryReader { geometry in
            List(self.donationList) {current in
                Group{
                    if(current.status<2){
                        Selection(order: current, phrase: "requested", you:false)
                            .frame(width:geometry.size.width,height:200)
                            .padding(.leading,-20)
                    } else{
                        EmptyView().hidden()
                    }
                }
            }
            .onAppear(perform: {
                self.manager.getDonations(userID: self.user.id) { (requests) in
                    self.donationList = []
                    for each in requests{
                        if(each.status>2){
                            self.donationList.append(each)
                        }
                    }
                }
            })
        }
    }
}

struct Completed_Previews: PreviewProvider {
    static var previews: some View {
        Completed().environmentObject(User())
    }
}
