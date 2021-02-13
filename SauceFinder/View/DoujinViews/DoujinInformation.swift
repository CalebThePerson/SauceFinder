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
        GeometryReader{ geo in
            ScrollView(.vertical){
                VStack{
                    Group{
//                        Spacer()
                        
                        Text(theDoujin!.Name)
                            .font(.title)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(alignment:.center)
                            .padding([.leading, .trailing,.top], 50)
                        //                            .font(.headline)
                        
                        
                        
                        Text("Sauce:\(theDoujin!.Id)")
                            .font(.title2)
                            .padding(.bottom, 25)
                        
                        
                        Text("Tags:")
                            .frame(alignment: .center)
                        
                        TagView(tagArray: theDoujin!.Tags)
                            .padding(.bottom, 150)
                            .padding([.trailing, .leading], 10)
                        
                        
                        
                        Spacer()
                        
                        ImageView(image: convertBase64ToImage(theDoujin!.PictureString))
                            .frame(alignment:.center)
                            .padding([.leading, .trailing], 50)
                        

                        
                    }
                }
            }
        }
        .frame(alignment:.center)
    }
}

struct DoujinInformation_Previews: PreviewProvider {
    static var previews: some View {
        DoujinInformation(theDoujin: .constant(DoujinInfo()))
    }
}

extension DoujinInformation{
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
