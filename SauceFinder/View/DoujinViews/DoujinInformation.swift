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
        ScrollView {
            
            VStack {
                
                Text(doujinModel.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.leading, .trailing,.top], 50)
                
                
                Text("Sauce:\(doujinModel.id)")
                    .font(.title2)
                
                Text("\(doujinModel.numPages) pages")
                    .font(.title2)
                    .padding(.bottom, 25)
                
                Text("Tags")
                
                TagView(tagArray: doujinModel.doujinTags)
                    .padding(.bottom, 150)
                    .padding([.trailing, .leading], 10)
                
                Spacer()
                
                Image(uiImage: convertBase64ToImage(doujinModel.pictureString))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.horizontal, 50)
                
                
            }
            .overlay(
                VStack {
                    HStack {
                        Button(action: {
                            alertShow.toggle()
                        }) {
                            Image(systemName: "trash.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width:25, height: 25)
                        }
                        .padding(10)
                        
                        Spacer()
                    }
                    Spacer()
                }
            )
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
