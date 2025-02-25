//
//  Selection.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/17/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Selection: View {
    @ObservedObject var order:Request
    @State var phrase:String
    @EnvironmentObject var user:User
    @State var you:Bool
    @State var starred:Bool
    
    var body: some View {
        GeometryReader{geometry in
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.04)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .frame(maxWidth: geometry.size.width/1.2, maxHeight:100)
                    .padding(.horizontal,50)
                    .offset(x:geometry.size.width/50)
                
                HStack {
                    Spacer()
                    
                    Text("\(self.order.num) \(self.order.item)")
                        .font(.system(size: 40))
                        .fontWeight(.light)
                        .frame(height:80,alignment: .leading)
                        .minimumScaleFactor(0.005)
                        .padding(.leading,50)
                        .padding(.trailing,-20)
                        .frame(maxWidth:geometry.size.width/1.8)

                    Spacer()
                    
                    if(self.starred){
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30, height:30)
                            .foregroundColor(Color.purple)
                    }
                    
                    Image(systemName: "chevron.right.2")
                        .padding(.trailing,50+geometry.size.width/30)
                        .foregroundColor(Color.gray)
                }
            }
            .frame(width:geometry.size.width,height:100)
            .padding(.leading,-20)
        }
    }
}

struct Selection_Previews: PreviewProvider {
    static var previews: some View {
        Selection(order: Request(), phrase:"are requesting", you: true, starred: true)
    }
}
