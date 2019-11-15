//
//  MsgPage.swift
//  CSR-Chat
//
//  Created by Cody Sugarman on 08/11/2019.
//  Copyright © 2019 csr.com. All rights reserved.
//

import SwiftUI

struct MsgPage : View {
    
    var session: FirebaseSession
    
    @ObservedObject var msg = FirebaseSession()
    @State var typedMsg = ""
    
    var body : some View {
        
        VStack {
            List(session.msgs) { i in
                if i.email == self.session.session.email {
                    MsgRow(msg: i.msg, isMyMsg: true, email: i.email)
                } else {
                    MsgRow(msg: i.msg, isMyMsg: false, email: i.email)
                }
            }
            .navigationBarTitle("Chats", displayMode: .inline)
            
            HStack {
                TextField("Enter message here", text: $typedMsg).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    self.msg.addMsg(msg: self.typedMsg, email: self.session.session.email!)
                    self.typedMsg = ""
                }) {
                    Text("Send")
                }
                
            }
        .padding()
        }
    }
}

struct MsgPage_Previews: PreviewProvider {
    static var previews: some View {
        MsgPage(session: FirebaseSession())
    }
}
