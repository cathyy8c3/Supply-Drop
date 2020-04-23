//
//  Active.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Active: View {
    @EnvironmentObject var user:User
    @State var manager:Api = Api()
    @State var donationList:[Request] = []

    var body: some View {
        GeometryReader { geometry in
            List(self.donationList) {current in
                Group{
                    if(current.status<2){
                        Selection(order: current, phrase: "is requesting", you:false)
                            .frame(width:geometry.size.width,height:200)
                            .padding(.leading,-20)
                    }else{
                        EmptyView().hidden()
                    }
                }
            }
        .onAppear(perform: {
            self.manager.getDonations(userID: self.user.id) { (requests) in
                for each in requests{
                    if(each.status<2){
                        self.donationList.append(each)
                    }
                }
            }
        })

            
        }
    }
}

struct Active_Previews: PreviewProvider {
    static var previews: some View {
        Active().environmentObject(User())
    }
}
