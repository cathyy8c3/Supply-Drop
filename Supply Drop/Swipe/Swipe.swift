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
    
    @ObservedObject  var order:Request = Request()
    
    var body: some View {
        PagerView(pageCount: 3, currentIndex: $currentPage) {
            //todo
            Donations()
            
            Circle_Hands()
            
            Request_Form(order:self.order)
        }
    }
}

struct Swipe_Previews: PreviewProvider {
    static var previews: some View {
        Swipe(order: Request())
    }
}
