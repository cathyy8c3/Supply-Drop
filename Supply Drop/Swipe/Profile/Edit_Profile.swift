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
    @State var username:String = ""
    @State var email:String = ""
    @State var oldpass:String = ""
    @State var pass1:String = ""
    @State var pass2:String = ""
    @State var presentMe:Bool = false
    @State var match:String = ""
    @State var address1:Address = Address()
    @State var valid:String = ""
    
    @State var image:Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func isValidUsername(username:String)->Bool{
        return username.isAlphanumeric
    }
    
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
                                
//                                Text("Edit")
//                                    .foregroundColor(Color.purple)
//                                    .padding(.bottom, geometry.size.width/9)
                                
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
                            
                            TextField("Name", text: self.$user.name)
                            .padding()
                                .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            TextField("Username", text: self.$user.username)
                            .padding()
                                .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            TextField("Email", text: self.$user.email)
                            .padding()
                            .frame(width:275, height:50)
                            .border(Color.gray, width:0.5)
                            
                            Text(self.valid)
                                .foregroundColor(Color.red)
                                
                            VStack(spacing:20){
                                    Text("Address")
                                        .font(.body)
                                        .padding(.top,20)
                                    
                                TextField("Address Line 1", text: self.$user.initAddress.address1)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)

                                    
                                    TextField("Address Line 2", text: self.$user.initAddress.address2)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)
                                    
                                    HStack {
                                        TextField("City", text: self.$user.initAddress.city)
                                        .padding()
                                        .frame(width:geometry.size.width/1.2-geometry.size.width/2.3-15, height:50)
                                        .border(Color.gray, width:0.5)
                                        
                                        TextField("State", text: self.$user.initAddress.state)
                                            .padding()
                                            .frame(width:75, height:50)
                                            .border(Color.gray, width:0.5)
                                            
                                        TextField("Zip Code", text: self.$user.initAddress.zip)
                                            .keyboardType(.numberPad)
                                            .padding()
                                            .frame(width:geometry.size.width/2.3-75, height:50)
                                            .border(Color.gray, width:0.5)
                                    }
                                    
                                    TextField("Country", text: self.$user.initAddress.country)
                                    .padding()
                                    .frame(width:geometry.size.width/1.2, height:50)
                                    .border(Color.gray, width:0.5)
                                }.padding(.bottom, 20)
                                    
                                
                            }
                            .padding(.bottom,30)
                                
                            SecureField("Current Password", text: self.$oldpass)
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
                        
                        Button(action: {
                            if(self.oldpass==self.user.password){
                                self.match=""
                                if(self.pass1==self.pass2){
                                    self.user.password=self.pass1
                                    self.match=""
                                    
                                    if(!self.isValidPassword(testStr: self.pass1)){
                                        self.match = "Invalid password."
                                    }else{
                                        self.match=""
                                        if(!self.isValidUsername(username: self.username)){
                                            self.valid = "Invalid username."
                                        }else if(!self.isValidEmail(email:self.email)){
                                            self.valid = "Invalid email."
                                        }else{
                                            //todo
                                            //save
                                            
                                            self.valid=""
                                            
                                            self.user.setAddress(add:self.user.initAddress)
                                            
                                            self.user.password = self.pass1
                                            
                                            self.presentMe=true
                                        }
                                    }
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
                                .padding([.bottom,.top],30)
                        }
                        .frame(width:500)
                        
                        NavigationLink(destination: Profile(), isActive: self.$presentMe) { EmptyView() }
                    
                        Spacer()
                    }
                }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                //.frame(height:geometry.size.height)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .offset(y: -keyboardResponder.currentHeight*0.9)
//            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//                    ImagePicker(image: self.$inputImage)
//            }
        
    }
    
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        self.image = Image(uiImage: inputImage)
//    }
}

struct Edit_Profile_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Profile().environmentObject(User())
    }
}
