//
//  LoginView.swift
//  CSR-Chat
//
//  Created by Cody Sugarman on 08/11/2019.
//  Copyright © 2019 csr.com. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""

    @State var showingAlert = false
    @State var errorMsg = ""
    
    let logoWidth = CGFloat(150.0)
    let logoHeight = CGFloat(70.0)
    let topPad = CGFloat(12.0)
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange
                VStack {
                    Image("CSRColourLogo").resizable().frame(width: logoWidth, height: logoHeight).padding(.top, topPad)
                    
                    HStack {
                        Image(systemName: "person.fill").resizable().frame(width: 20, height: 20)
                        TextField("Email", text: $email).padding(.leading, 12).font(.system(size: 20))

                    }
                    .padding(12)
                    
                    HStack {
                        Image(systemName: "lock.fill").resizable().frame(width: 15, height: 20).padding(.leading, 3)
                        SecureField("Password", text: $password).padding(.leading, 12).font(.system(size: 20))
                    }
                    .padding(12)
                    
                    Button(action: logIn) {
                        Text("Login")
                    }
                    .frame(width: 150, height: 54)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 15)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("\(self.errorMsg)"), dismissButton: .default(Text("Got it!")))
                    }
                    
                    Text("Don't have an account yet?").italic().padding()
                
                    NavigationLink(destination: SignUp()) {
                        Text("Signup")
                    }
                    .navigationBarBackButtonHidden(false)
                    .frame(width: 150, height: 54)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 15)
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func logIn() {
        session.logIn(email: email, password: password) { (result, error) in
            if error != nil {
                self.showingAlert = true
                self.errorMsg = error!.localizedDescription
            } else {
                self.showingAlert = false
                self.errorMsg = ""
                self.session.session?.email = self.email
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
