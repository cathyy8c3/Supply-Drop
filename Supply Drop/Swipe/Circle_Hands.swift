//
//  Circle_Hands.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Circle_Hands: View {
    var body: some View {
        ZStack{
            Image("hands_circle")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
            
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.4)
            
            VStack (spacing:50){
                Spacer()
                VStack {
                    Text("Swipe right to donate")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                    
                    Image("arrow_top")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:400)
                        .aspectRatio(0.9, contentMode: .fit)
                }
                
                VStack {
                    Image("arrow_bottom")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:400)
                        .aspectRatio(0.9, contentMode: .fit)
                    
                    Text("Swipe left to request")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                }
                
                Spacer()
            }
        }
    }
}

struct Circle_Hands_Previews: PreviewProvider {
    static var previews: some View {
        Circle_Hands()
    }
}
