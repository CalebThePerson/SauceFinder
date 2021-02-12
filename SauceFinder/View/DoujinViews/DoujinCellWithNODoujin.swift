//
//  DoujinCellWithNODoujin.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/3/20.
//

import SwiftUI

struct DoujinCellWithNODoujin: View {
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(imageLiteralResourceName: "TestingOne"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .clipped()
        }
    }
}

struct DoujinCellWithNODoujin_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            DoujinCellWithNODoujin()
        }
    }
}
