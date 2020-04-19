//
//  MessageView.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/18/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var user2:User
    
    var body: some View {
         HStack(alignment: .bottom, spacing: 15) {
            user2.profile
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
          ContentMessageView(contentMessage: "There are a lot of premium iOS templates on iosapptemplates.com",
                             isCurrentUser: false)
       }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(user2: User())
    }
}
