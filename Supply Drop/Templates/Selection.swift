//
//  Selection.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Selection: View {
    @ObservedObject var order:Order
    @State var phrase:String
    @EnvironmentObject var user:User
    @State var you:Bool
    
    var body: some View {
        
        GeometryReader{geometry in
            ZStack {
                
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.04)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .frame(maxWidth: geometry.size.width/1.2, maxHeight:100)
                    .padding(.all,50)
                    .offset(x:geometry.size.width/50)
                
                HStack {
//                    self.order.getRequester().profile
//                        .resizable()
//                        .scaledToFit()
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.white,lineWidth: 2))
//                        .frame(minWidth:150,maxWidth:200,minHeight:150,maxHeight:250)
                    Spacer()
                    
                    Text("\(self.you ? "You": self.order.getRequester().name) \(self.phrase) \(self.order.num) \(self.order.item)")
                        .font(.system(size: 40))
                        .fontWeight(.light)
                        .frame(height:80,alignment: .leading)
                        .minimumScaleFactor(0.005)
                        .padding(.leading,30)
                        .padding(.trailing,-20)
                        .frame(maxWidth:geometry.size.width/1.8)

                        
                    Spacer()
                    
                    Image(systemName: "chevron.right.2")
                        .padding(.trailing,50+geometry.size.width/30)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct Selection_Previews: PreviewProvider {
    static var previews: some View {
        Selection(order: Order(), phrase:"are requesting", you: true)
    }
}
