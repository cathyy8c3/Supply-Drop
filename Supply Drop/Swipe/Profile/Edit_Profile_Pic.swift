//
//  Edit_Profile_Pic.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Edit_Profile_Pic: View {
    @EnvironmentObject var user:User
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var image:Image?
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in

                ZStack (alignment:.bottom){
                    self.user.profile
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode:.fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .overlay(Circle().stroke(Color.white,lineWidth: 2))
                        .frame(width:geometry.size.width/2,height:geometry.size.width/2)
                    
                    Text("Edit")
                        .foregroundColor(Color.purple)
                        .padding(.bottom, geometry.size.width/9)
                    
                    self.image?
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode:.fit)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .overlay(Circle().stroke(Color.white,lineWidth: 2))
                        .frame(width:geometry.size.width/2,height:geometry.size.width/2)
                }
                .frame(width:geometry.size.width/2,height:geometry.size.width/2)
                .onTapGesture {
                    self.showingImagePicker=true
                }
            }
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: self.$inputImage)
    }
    
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        self.image = Image(uiImage: inputImage)
    }
}

struct Edit_Profile_Pic_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Profile_Pic().environmentObject(User())
    }
}
