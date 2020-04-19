//
//  Edit_Profile.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/15/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct Edit_Profile: View {
    @EnvironmentObject var user:User
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    @State var name:String = ""
    @State var email:String = ""
    @State var oldpass:String = ""
    @State var pass1:String = ""
    @State var pass2:String = ""
    @State var presentMe:Bool = false
    @State var match:String = ""
    
    @State var image:Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                ScrollView{
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            self.showingImagePicker=true
                        }) {
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
                            .padding(.top,50)
                        }
                        
                        VStack(spacing:20) {
                            Text("Profile")
                                .font(.largeTitle)
                                .padding(.top,10)
                                .frame(width:300)
                            
                            TextField("Name", text: self.$name)
                            .padding()
                                .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            TextField("Email", text: self.$email)
                            .padding()
                            .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            .padding(.bottom,30)
                                
                            SecureField("Old Password", text: self.$oldpass)
                            .padding()
                            .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            SecureField("Type Your New Password", text: self.$pass1)
                            .padding()
                            .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            SecureField("Type Your New Password Again", text: self.$pass2)
                            .padding()
                            .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            Text("\(self.match)")
                                .foregroundColor(Color.red)
                        }
//                        .padding(.bottom,25)
                        
//                        Spacer()
                        
                        NavigationLink(destination: Profile(), isActive: self.$presentMe) { EmptyView() }
                        
                        Button(action: {
                            self.user.name = self.name
                            self.user.email = self.email
                            self.user.profile = self.image ?? self.user.profile
                            
                            if(self.oldpass==self.user.password){
                                
                                if(self.pass1==self.pass2){
                                    self.user.password=self.pass1
                                    self.presentMe=true
                                }else{
                                    self.match = "Passwords don't match."
                                    self.pass1 = ""
                                    self.pass2 = ""
                                }
                                
                            }else{
                                self.match = "Incorrect password."
                            }
                        }) {
                            Text("Save")
                                .foregroundColor(Color.purple)
                                .padding(.bottom,30)
                        }
                        .frame(width:500)
                        
                        Spacer()
                    }
                }
                //.frame(height:geometry.size.height)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .offset(y: -keyboardResponder.currentHeight*0.9)
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        self.image = Image(uiImage: inputImage)
    }
}

struct Edit_Profile_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Profile().environmentObject(User())
    }
}
