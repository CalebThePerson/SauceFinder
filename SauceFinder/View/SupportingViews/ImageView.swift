//
//  ImageView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 2/12/21.
//

import SwiftUI

struct ImageView: View {
    var image: UIImage
    
    var body: some View {
        VStack{
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 400)
                .clipped()
        }
        .frame(height: 200)

    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: UIImage(imageLiteralResourceName: "Lewd"))
    }
}
