//
//  Active_Requests.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Active_Requests: View {
    @State var manager:Api = Api()
    @State var requestList:[Request] = []
    
    @EnvironmentObject var user:User
    
    var body: some View {
        GeometryReader { geometry in
            List(self.requestList) {current in
                NavigationLink(destination:Your_Request_Details(order: current)){
                    Group{
                        if(current.status<2){
                            Selection(order: current, phrase: "are requesting", you:true, starred: current.status == 1)
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
                self.manager.getRequests(userID: self.user.id) { (requests) in
                    self.requestList = []
                    for each in requests{
                        if(each.status<2){
                            each.setAdress(add: each.addressString.toAddress(address: each.addressString))
                            
                            self.requestList.append(each)
                        }
                    }
                }
            })
        }
    }
}

struct Active_Requests_Previews: PreviewProvider {
    static var previews: some View {
        Active_Requests().environmentObject(User())
    }
}
