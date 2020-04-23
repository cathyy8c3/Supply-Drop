//
//  Thank_You.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/19/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Thank_You: View {
    var body: some View {
//        NavigationView {
            VStack {
                Circle_logo_3()
                .padding([.leading, .trailing],140)
                    .padding(.bottom, 50)
                
                Text("Your request has been processed!")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                    .shadow(color:Color.purple,radius: 35)
                    .padding(.bottom,100)
                
                NavigationLink(destination:Swipe(currentPage:1)){
                    Text("Return")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(Color.purple)
                }
            
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
//        }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Thank_You_Previews: PreviewProvider {
    static var previews: some View {
        Thank_You()
    }
}
