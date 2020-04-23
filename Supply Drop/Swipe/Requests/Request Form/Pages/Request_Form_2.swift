//
//  Request_Form_2.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_Form_2: View {
    @State var checked:Bool = false
    @State var unchecked:String = ""
    @State var next:Bool = false
    
    @ObservedObject var order:Request
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                MapView(address: self.order.address.getLoc())
                    .frame(height:geometry.size.height/1.5)
                    .offset(y:-40)
                
                Spacer()
                
                Divider()
                
                Spacer()
                
                HStack{
                    Button(action:{
                        self.checked.toggle()
                    }) {
                        if(self.checked){
                            Image(systemName: "checkmark.square.fill")
                            .renderingMode(.original)
                        }
                        else{
                            Image(systemName: "square")
                            .renderingMode(.original)
                        }
                    }
                    
                    Text("I agree that I am not creating a fraudulent request.")
                        .frame(width:geometry.size.width/1.4)
                }
                
                Text(self.unchecked)
                    .foregroundColor(Color.red)
                    .font(.subheadline)
                
                Spacer()
                
                Button(action: {
                    if(!self.checked){
                        self.unchecked = "Please agree to the terms."
                    }else{
                        self.next=true
                    }
                }) {
                    Text("Verify Your Location")
                        .font(.body)
                        .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination:Request_Form_3(order:self.order),isActive: self.$next){EmptyView()}
                
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Request_Form_2_Previews: PreviewProvider {
    static var previews: some View {
        Request_Form_2(order: Request())
    }
}
