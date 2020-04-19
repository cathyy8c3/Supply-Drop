//
//  Request_Form_2.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Request_Form_2: View {
    @State var checked = false
    @ObservedObject var order:Order
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                VStack {
                    //fix coordinates
                    MapView()
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
                        
                        Text("I agree that I am not creating a fraudulent request and am following the terms and conditions.")
                            .frame(width:geometry.size.width/1.4)
                    }
                    Spacer()
                    
                    Button(action: {
                        //todo
                    }) {
                        Text("Verify Your Location")
                        .font(.body)
                            .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!self.checked)
                    
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .offset(y: -keyboardResponder.currentHeight*0.9)
    }
}

struct Request_Form_2_Previews: PreviewProvider {
    static var previews: some View {
        Request_Form_2(order: Order())
    }
}
