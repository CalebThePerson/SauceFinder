//
//  DoujinCell.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/2/20.
//

import SwiftUI

struct DoujinCell: View {
    var image: UIImage
    
    var body: some View {
        
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .clipped()
        }

    }
}

struct DoujinCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { Geo in
            DoujinCell(image: UIImage(imageLiteralResourceName: "TestingOne"))
        }
    }
}

