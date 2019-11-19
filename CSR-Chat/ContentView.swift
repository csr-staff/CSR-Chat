//
//  ContentView.swift
//  CSR-Chat
//
//  Created by Cody Sugarman on 23/10/2019.
//  Copyright © 2019 csr.com. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {

    @ObservedObject var session = FirebaseSession()
    @State var successAlert = true

    var body: some View {
        NavigationView {
            Group {
                if session.session != nil {
                    MsgPage(session: session)
                    .navigationBarItems(trailing: Button(action: {
                        self.session.logOut()
                        self.session.session = nil
                    }) {
                        Text("Logout")
                    })
                } else {
                    LoginView().environmentObject(session)
                    .navigationBarItems(trailing: Text(""))
                }
            }
            .onAppear(perform: getUser)
        }
    }

    func getUser() {
        session.getUser()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
