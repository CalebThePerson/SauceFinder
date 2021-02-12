//
//  DoujinInformation.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/3/21.
//

import SwiftUI

struct DoujinInformation: View {
    @Binding var TheDoujin: DoujinInfo?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text("PEEEPEEEPPOOOPOOOOOOO")
    }
}

struct DoujinInformation_Previews: PreviewProvider {
    static var previews: some View {
        DoujinInformation(TheDoujin: .constant(DoujinInfo()))
    }
}
