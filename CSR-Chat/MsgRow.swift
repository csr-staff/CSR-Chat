//
//  MsgRow.swift
//  CSR-Chat
//
//  Created by Cody Sugarman on 08/11/2019.
//  Copyright © 2019 csr.com. All rights reserved.
//

import SwiftUI

struct MsgRow : View {
    var isMyMsg = false
    var msg = ""
    var email = ""
    
    var body : some View {
        HStack {
            if isMyMsg {
                Spacer()
                Text(msg).padding(8).background(Color.blue).cornerRadius(6).foregroundColor(Color.white)
            } else {
                VStack(alignment: .leading) {
                    Text(msg).padding(8).background(Color.green).cornerRadius(6).foregroundColor(Color.white)
                    Spacer()
                    Text(email).font(.footnote).italic()
                }
            }
        }
    }
}

struct MsgRow_Previews: PreviewProvider {
    static var previews: some View {
        MsgRow()
    }
}
