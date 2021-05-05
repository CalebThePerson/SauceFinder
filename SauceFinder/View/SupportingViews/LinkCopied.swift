//
//  LinkCopied.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 4/21/21.
//

import SwiftUI

struct LinkCopied: View {
    @Binding var showing:Bool
    
    var body: some View {
        if showing == true{
            Text("Link has been copied")
                .onAppear(perform : msgShown)
        }
    }
}

struct LinkCopied_Previews: PreviewProvider {
    static var previews: some View {
        LinkCopied(showing: .constant(false))
    }
}


