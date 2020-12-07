//
//  DoujinCell.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/2/20.
//

import SwiftUI

struct DoujinCell: View {
    var TheImage: UIImage
    var ScreenSize: CGSize
    
    var body: some View {
        
        VStack {
            Image(uiImage: TheImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ScreenSize.width, height: 140)
                .clipped()
        }
        .frame(width: ScreenSize.width, height: 140)

    }
}

struct DoujinCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { Geo in
            DoujinCell(TheImage: UIImage(imageLiteralResourceName: "TestingOne"), ScreenSize: Geo.size)
        }
    }
}

