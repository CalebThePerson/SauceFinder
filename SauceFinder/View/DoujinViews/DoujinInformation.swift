//
//  DoujinInformation.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/3/21.
//

import SwiftUI

struct DoujinInformation: View {
    @Binding var theDoujin: DoujinInfo?
    
    var body: some View {
        Text("Hello, World!")
        Text("PEEEPEEEPPOOOPOOOOOOO")
    }
}

struct DoujinInformation_Previews: PreviewProvider {
    static var previews: some View {
        DoujinInformation(theDoujin: .constant(DoujinInfo()))
    }
}
