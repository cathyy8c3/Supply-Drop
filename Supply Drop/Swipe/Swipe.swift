//
//  Swipe.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Swipe: View {
    @State var currentPage:Int
    
    @EnvironmentObject var orders:Orders
    @EnvironmentObject var user:User
    
    @ObservedObject var manager:Api = Api()
    @ObservedObject  var order:Request = Request()
    
    var body: some View {
        PagerView(pageCount: 3, currentIndex: $currentPage) {
            Donations()
            
            Circle_Hands()
            
            Request_Form(order:self.order)
        }
        .onAppear(perform:{
            DispatchQueue.main.async {
                self.manager.getAvailable { (order2) in
                    self.orders.setOrders2Orders(order1:order2, user1:self.user)
                }
            }
        })
    }
}

struct Swipe_Previews: PreviewProvider {
    static var previews: some View {
        Swipe(currentPage: 1)
    }
}
