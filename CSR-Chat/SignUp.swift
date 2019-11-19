//
//  SignUp.swift
//  CSR-Chat
//
//  Created by Cody Sugarman on 08/11/2019.
//  Copyright © 2019 csr.com. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirm: String = ""

    @State var showingAlert = false
    @State var errorMsg = ""
    
    let personWidth = CGFloat(60.0)
    let personHeight = CGFloat(60.0)
    let topPad = CGFloat(12.0)
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.orange
                VStack {
                    Image(systemName: "person.circle.fill").resizable().frame(width: personWidth, height: personHeight).padding(.top, topPad)

                    HStack {
                        Image(systemName: "person.fill").resizable().frame(width: 20, height: 20)
                        TextField("Email", text: $email).padding(.leading, 12).font(.system(size: 20))

                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    HStack {
                        Image(systemName: "lock.fill").resizable().frame(width: 15, height: 20).padding(.leading, 3)
                        SecureField("Password", text: $password).padding(.leading, 12).font(.system(size: 20))
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    HStack {
                        Image(systemName: "lock.fill").resizable().frame(width: 15, height: 20).padding(.leading, 3)
                        SecureField("Confirm Password", text: $passwordConfirm).padding(.leading, 12).font(.system(size: 20))
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    Button(action: signUp) {
                        Text("Sign Up!")
                    }
                    .frame(width: 150, height: 54)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 15)
                        
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("\(self.errorMsg)"), dismissButton: .default(Text("Got it!")))
                    }
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if self.password != self.passwordConfirm {
                self.showingAlert = true
                self.errorMsg = "Password and password confirmation must match"
                return
            }
            if error != nil {
                self.showingAlert = true
                self.errorMsg = error!.localizedDescription
            } else {
                self.session.session?.email = self.email
                self.showingAlert = false
                self.errorMsg = ""
            }
        }
    }
    
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
