//
//  DoujinInformation.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/3/21.
//

import SwiftUI

struct DoujinInformation: View {
    @Binding var theDoujin: DoujinInfo?
    @State var alertShow:Bool = false
    @Environment(\.presentationMode) var presentationMode
    var theAPI:DoujinAPI

    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                ZStack{
                    
                    Button(action: {
                        alertShow.toggle()
                    }) {
                        Image(systemName: "trash.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width:25, height: 25)
                        
                    }
                    .offset(x:-160, y:-235)
                    
                    
                    VStack{
                        Group{
                            
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
//                                .padding(.bottom, 25)
                            
                            Text("\(theDoujin!.NumPages) pages")
                                .font(.title2)
                                .padding(.bottom, 25)
                            
                            
                            Text("Tags")
                                .frame(alignment: .center)
                            
                            TagView(tagArray: theDoujin!.Tags)
                                .padding(.bottom, 150)
                                .padding([.trailing, .leading], 10)
                            
                            
//                            Text("\(theDoujin!.NumPages) pages")

                            
                            
                            
                            Spacer()
                                                        
                            ImageView(image: convertBase64ToImage(theDoujin!.PictureString))
                                .frame(alignment:.center)
                                .padding([.leading, .trailing], 50)
                            
                            
                            
                            
                        }
                        .alert(isPresented: $alertShow){
                            Alert(title: Text("Would you like to delete this entry"),message: Text(theDoujin!.Name),primaryButton:
                                    .default(Text("Delete")) {
                                        theAPI.removing = true
                                        presentationMode.wrappedValue.dismiss()
//                                        SauceFinder.delete(doujin: theDoujin!)
                                    }, secondaryButton: .cancel())
                        }
                    }
                }
            }
        }
        .frame(alignment:.center)
    }
}

struct DoujinInformation_Previews: PreviewProvider {
    static var previews: some View {
        DoujinInformation(theDoujin: .constant(DoujinInfo()), theAPI: DoujinAPI())
    }
}

extension DoujinInformation{
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
