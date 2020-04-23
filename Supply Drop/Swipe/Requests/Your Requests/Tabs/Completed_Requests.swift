//
//  Completed_Requests.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Completed_Requests: View {
    @EnvironmentObject var user:User
    @State var manager:Api = Api()
    
    @State var requestList:[Request] = []
    
    var body: some View {
            GeometryReader { geometry in
                List (self.requestList){current in
                    Group{
                        if(current.status<2){
                            Selection(order: current, phrase: "requested", you:true)
                                .frame(width:geometry.size.width,height:200)
                                .padding(.leading,-20)
                        }else{
                            EmptyView().hidden()
                        }
                    }
                }
                .onAppear(perform: {
                    self.manager.getRequests(userID: self.user.id) { (requests) in
                        
                        self.requestList = []
                        for each in requests{
                            if(each.status>2){
                                self.requestList.append(each)
                            }
                        }
                    }
                })
                
            }

    
    }
}

struct Completed_Requests_Previews: PreviewProvider {
    static var previews: some View {
        Completed_Requests()
    }
}
