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
                NavigationLink(destination:Request_Detail(order: current)){
                    Group{
                        if(current.status>=2){
                            Selection(order: current, phrase: "requested", you:false, starred: false)
                                .frame(width:geometry.size.width,height:120)
                                .padding(.leading,-20)
                        } else{
                            EmptyView().hidden()
                        }
                    }
                }
            }
            .onAppear(perform: {
                UITableView.appearance().separatorColor = .clear
                self.manager.getDonations(userID: self.user.id) { (requests) in
                    self.donationList = []
                    for each in requests{
                        if(each.status>=2){
                            each.setAdress(add: each.addressString.toAddress(address: each.addressString))
                            
                            if(each.donorID ?? -1 > -1){
                                self.manager.getUser(userID: each.donorID ?? -1) { donor in
                                    each.donor.tempUser22User(user2:donor[0])
                                }
                            }
                            
                            self.manager.getUser(userID: each.requesterID) { donor in
                                each.requester.tempUser22User(user2:donor[0])
                            }
                            
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
