//
//  newUser.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/14/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI

struct newUser: View {
    @State var user:User
    @State var password1:String = ""
    @State var password2:String = ""
    @State var pass:Bool = false
    @ObservedObject var keyboardResponder = KeyboardResponder()
        
    func check() -> Void{
        if(password1==password2){
            pass=true
        }else{
            pass=false
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Spacer()
                    
                    Circle_logo_3()
                        .padding([.leading, .trailing],275)
    //                    .padding(.top,200)
                    
                    VStack (alignment: .center, spacing: 30){
                        Text("Sign Up")
                            .font(.largeTitle)
                            .fontWeight(.thin)
                            .shadow(radius: 10)
                        
                        VStack (spacing: 10){
                            TextField("Enter your name.", text: $user.name)
                                .padding()
                            .frame(width:300, height:50)
                            .border(Color.gray, width:0.5)
                            
                            TextField("Enter your email.", text: $user.email)
                                .padding()
                                .frame(width:300, height:50)
                                .border(Color.gray, width:0.5)
                            
                            TextField("Enter your username.", text: $user.username)
                                .padding()
                                .frame(width:300, height:50)
                                .border(Color.gray, width:0.5)
                                .padding(.bottom, 20)
                                
                            
                            SecureField("Enter your password.",text:$password1)
                                .padding()
                                .frame(width:300, height:50)
                                .border(Color.gray, width:0.5)
                            
                            SecureField("Enter your password again.",text:$password2)
                                .padding()
                                .frame(width:300, height:50)
                                .border(Color.gray, width:0.5)
                        }
                        
                            
                        VStack{
                            Button(action:{
                                //todo
                            }){
                                Text("Create Your Account")
    //                                        .padding(.top, 10)
                                    .font(.title)
                                    .foregroundColor(Color.purple)
                            }
                            .disabled(self.user.name.count==0 || self.user.name.count==0 || self.password1.count<8 || self.password2.count<8)
    //                                Spacer()
                            
                            Text("or")
                                .font(.body)
                                .foregroundColor(Color.gray)
                            
                            Google_Login()
                                .padding(.bottom,30)
    //                                    .frame(minWidth:0,minHeight:40)
                        }
                            
                            
                }
    //                .padding(.bottom,300)
                    
                    Spacer()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .offset(y: -keyboardResponder.currentHeight*0.9)
        
    }
    
//    func submitSignIn(){
//            guard let encoded = try? JSONEncoder().encode(User)
//                else{
//                    print("Failed to encode user.")
//                    return
//            }
//            
//    //        print("hello")
//            
//            let url = URL(string: "https://reqres.in/api/Users")!
//            
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            request.httpBody = encoded
//            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                // handle the result here.
//                guard let data = data else {
//                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
//                    return
//                }
//                
//                if (try? JSONDecoder().decode(User.self, from: data)) != nil {
//                    self.confirmationMessage = "Signed in."
//                    self.showingConfirmation = true
//                } else {
//                    print("Invalid response from server")
//                }
//            }.resume()
}

struct newUser_Previews: PreviewProvider {
    static var previews: some View {
        newUser(user: User())
    }
}
