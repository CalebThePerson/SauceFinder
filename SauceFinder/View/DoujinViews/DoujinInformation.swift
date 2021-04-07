//
//  DoujinInformation.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/3/21.
//

import SwiftUI

struct DoujinInformation: View {
    @State var alertShow:Bool = false
    @Environment(\.presentationMode) var presentationMode
    var theAPI:DoujinAPI
    var doujinModel: DoujinInfoViewModel

    
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
                            
                            Text(doujinModel.name)
                                .font(.title)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(alignment:.center)
                                .padding([.leading, .trailing,.top], 50)
                            //                            .font(.headline)
                            
                            
                            
                            Text("Sauce:\(doujinModel.id)")
                                .font(.title2)
//                                .padding(.bottom, 25)
                            
                            Text("\(doujinModel.numPages) pages")
                                .font(.title2)
                                .padding(.bottom, 25)
                            
                            
                            Text("Tags")
                                .frame(alignment: .center)
                            
                            TagView(tagArray: doujinModel.doujinTags)
                                .padding(.bottom, 150)
                                .padding([.trailing, .leading], 10)
                            
                            
                            Spacer()
                                                        
                            ImageView(image: convertBase64ToImage(doujinModel.pictureString))
                                .frame(alignment:.center)
                                .padding([.leading, .trailing], 50)
                            
                            
                            
                            
                        }
                        //This will ask the user if they would like to delete the current entry
                        .alert(isPresented: $alertShow){
                            Alert(title: Text("Would you like to Delete this entry"),message: Text(doujinModel.name),primaryButton:
                                    .default(Text("Delete")) {
                                        alertShow.toggle()
                                        doujinModel.deleting = true
                                        presentationMode.wrappedValue.dismiss()
                                    }, secondaryButton: .cancel())
                        }
                    }
                }
            }
        }
        .frame(alignment:.center)
    }
}

//struct DoujinInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        DoujinInformation(theDoujin: .constant(DoujinInfo()), theAPI: DoujinAPI() ,doujinModel: .constant(DoujinInfoViewModel))
//    }
//}

extension DoujinInformation{
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
