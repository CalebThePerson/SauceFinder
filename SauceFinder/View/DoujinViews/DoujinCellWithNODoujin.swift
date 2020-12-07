//
//  DoujinCellWithNODoujin.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/3/20.
//

import SwiftUI

struct DoujinCellWithNODoujin: View {
    let ScreenSize:CGSize

    var body: some View {
        VStack {
            Image(uiImage: UIImage(imageLiteralResourceName: "TestingWithOne"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ScreenSize.width, height: 140)
                .clipped()
        }
        .frame(width: ScreenSize.width, height: 140)
    }
}

struct DoujinCellWithNODoujin_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            DoujinCellWithNODoujin(ScreenSize: geo.size)
        }
    }
}
