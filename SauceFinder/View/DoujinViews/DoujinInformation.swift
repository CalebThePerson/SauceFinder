//
//  DoujinInformation.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/3/21.
//

import SwiftUI
import MobileCoreServices

struct DoujinInformation: View {
    @State private var alertShow:Bool = false
    @State private var copiedMsg:Bool = false
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
                    .padding(.bottom, 50)
                    .padding([.trailing, .leading], 10)
                
                //                Spacer()
                
                Image(uiImage: convertBase64ToImage(doujinModel.pictureString))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.horizontal, 50)
                    
                    //Once Tapped this wil copy the link to the doujin
                    .onTapGesture(count:1) {
                        UIPasteboard.general.string = "https://nhentai.net/g/\(doujinModel.id)/"
                        copiedMsg = true
                    }
                
                
            }
            .overlay(
                //Displays Link Copied message for 0.5 seconds
                VStack{
                    HStack{
                        if copiedMsg == true {
                            LinkCopied(showing: $copiedMsg)
                                .padding(.top, 20)
                        }
                    }
                }, alignment: .top)
            .overlay(
                //Delete Button overlay
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
            .overlay(
                //Similarity Portion
                VStack{
                    HStack{
                        switch doujinModel.color{
                        case .green:
                            VStack{
                                Image(systemName: "square.fill")
                                    .foregroundColor(Color(.green))
                                    .padding(.top,10)
                                Text("\(doujinModel.similarity, specifier: "%.2f")%")
                                
                                
                            }
                        case .yellow:
                            VStack{
                                Image(systemName: "square.fill")
                                    .foregroundColor(Color(.yellow))
                                    .padding(.top,10)
                                Text("\(doujinModel.similarity)%")
                                
                            }
                        case .red:
                            VStack{
                                Image(systemName: "square.fill")
                                    .foregroundColor(Color(.yellow))
                                    .padding(.top,10)
                                Text("\(doujinModel.similarity)%")
                            }
                        }
                    }
                }, alignment: .topTrailing)
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
        .background(Color(.clear))
        .background(Image(uiImage: convertBase64ToImage(doujinModel.pictureString))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.1)
                        .ignoresSafeArea())
    }
}

//struct DoujinInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        DoujinInformation(theDoujin: .constant(DoujinInfo()), theAPI: DoujinAPI() ,doujinModel: .constant(DoujinInfoViewModel))
//    }
//}

