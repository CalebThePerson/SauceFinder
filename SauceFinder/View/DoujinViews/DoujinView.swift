//
//  DoujinView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/2/20.
//

import SwiftUI
import RealmSwift
import Combine

enum ActiveAlert{
    case error, noSauce
}

struct DoujinView: View {
    @ObservedObject var doujin: DoujinAPI
    @StateObject var doujinModel = DoujinInfoViewModel()
    
    @State private var detailViewShowing: Bool = false
    @State private var selectedDoujin: DoujinInfo?
    @State private var deleteCell: Bool = false
    
    var gridItemLayout = [GridItem(.adaptive(minimum: 200)), GridItem(.adaptive(minimum: 200))]
    
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns : gridItemLayout, spacing: 5){
                ForEach(doujinModel.doujins){doujinshi in
                    VStack{
                        Image(uiImage: convertBase64ToImage(doujinshi.PictureString))
                            .resizable()
                            .cornerRadius(17)
                            .overlay(RoundedRectangle(cornerRadius: 17)
                                        .stroke(Color.black, lineWidth: 4))
                            .scaledToFit()
                            .frame(height: 300)
                            
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                        
                        //Provides the name but it makes the view look insnaley wonky, try to fix later
                        //                        Text(doujinshi.Name)
                        //                            .multilineTextAlignment(.center)
                        //                            .fixedSize(horizontal: false, vertical: false)
                    }
                    
                    .overlay(
                        VStack{
                            if deleteCell == true{
                                Button(action: {
                                    deleteCell.toggle()
                                    doujinModel.selectedDoujin = doujinshi
                                    doujinModel.deleteDoujin()
                                    
                                }){
                                    Image(systemName: "trash.circle")
                                        .foregroundColor(Color.red)
                                        .frame(height: 20)
                                }
                            }
                        }, alignment: .bottomLeading)

                    .padding([.leading, .trailing], 10)
                    
                    
                    
                    .onTapGesture(count: 1){
                        doujinModel.selectedDoujin = doujinshi
                        detailViewShowing.toggle()
                        deleteCell = false
                    }
                    
                    .onLongPressGesture {
                        deleteCell.toggle()
                    }
                }
                
                //                Loading circle
                if doujin.loadingCircle == true{
                    LoadingCircle(theApi: doujin)
                }
            }
            
            //This will preseent the sheet that displays information for the doujin
            .sheet(isPresented: $detailViewShowing, onDismiss: {if doujinModel.deleting == true {doujinModel.deleteDoujin()}}, content: {
                DoujinInformation(theAPI: doujin, doujinModel: doujinModel)
            })
            
            
            //Alert if the sauce can't be found
            .alert(isPresented: $doujin.showAlert){
                switch doujin.activeAlert{
                case .error:
                    return Alert(title: Text("Sorry"), message: Text("There was an error please report to Devs"), dismissButton: .default(Text("Dismiss")){
                        doujin.showAlert.toggle()
                    })
                    
                case .noSauce:
                    return Alert(title: Text("Sorry"), message: Text("Couldn't find that Sauce"), dismissButton: .default(Text("Dismiss")){
                        doujin.showAlert.toggle()
                    })
                case .none:
                    return Alert(title: Text("Sorry"), message: Text("There is an error please report to dev"), dismissButton: .default(Text("Dismiss")){
                        doujin.showAlert.toggle()
                    })
                    
                }
            }
        }
    }
}


//struct DoujinView_Previews: PreviewProvider {
//    static var previews: some View {
//        DoujinView(doujin: DoujinAPI())
//    }
//}
