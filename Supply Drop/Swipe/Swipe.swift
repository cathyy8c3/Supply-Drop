//
//  Swipe.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Swipe: View {
    @State private var currentPage = 1
    @EnvironmentObject var orders:Orders
    @State var manager:Api = Api()
    
    @ObservedObject  var order:Request = Request()
    
    var body: some View {
        PagerView(pageCount: 3, currentIndex: $currentPage) {
            //todo
            Donations()
            
            Circle_Hands()
            .onAppear{
                DispatchQueue.main.async {
                    for i in (0..<self.orders.orders.count){
                        if(self.orders.orders[i].donorID ?? -1>=0){
                            self.manager.getUser(userID: self.orders.orders[i].donorID ?? -1) { (user1) in
                                self.orders.orders[i].donor.tempUser22User(user2:user1[0])
                            }
                        }
                        if(self.orders.orders[i].requesterID>=0){
                            self.manager.getUser(userID: self.orders.orders[i].requesterID ) { (user1) in
                                self.orders.orders[i].requester.tempUser22User(user2:user1[0])
                            }
                        }
                    }
                }
            }
            
            Request_Form(order:self.order)
        }
        .onAppear{
            DispatchQueue.main.async {
                for i in (0..<self.orders.orders.count){
                    if(self.orders.orders[i].donorID ?? -1>=0){
                        self.manager.getUser(userID: self.orders.orders[i].donorID ?? -1) { (user1) in
                            self.orders.orders[i].donor.tempUser22User(user2:user1[0])
                        }
                    }
                    if(self.orders.orders[i].requesterID>=0){
                        self.manager.getUser(userID: self.orders.orders[i].requesterID ) { (user1) in
                            self.orders.orders[i].requester.tempUser22User(user2:user1[0])
                        }
                    }
                }
            }
        }
    }
}

struct Swipe_Previews: PreviewProvider {
    static var previews: some View {
        Swipe(order: Request())
    }
}
