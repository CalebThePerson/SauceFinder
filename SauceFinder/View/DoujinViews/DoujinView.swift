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
    //    @ObservedResults(DoujinInfo.self) var doujinshis
    @State private var detailViewShowing: Bool = false
    @State private var selectedDoujin: DoujinInfo?
    
    @StateObject var doujinModel = DoujinInfoViewModel()
    var body: some View {
        //Code if there are any Doujins
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(doujinModel.doujins, id: \.UniqueID) { doujinshi in
                    Button(action: {
                        self.detailViewShowing = true
                        self.doujinModel.selectedDoujin = doujinshi
                        
                    }) {
                        DoujinCell(image: convertBase64ToImage(doujinshi.PictureString))
                    }
                }
                
                
                //                .onDelete(perform: { indexSet in
                //                    self.doujinModel.easyDelete(at: indexSet)
                //                })
                
                
                //This will preseent the sheet that displays information for the doujin
                .sheet(isPresented: $detailViewShowing, onDismiss: {if doujinModel.deleting == true {doujinModel.deleteDoujin()}}, content: {
                    DoujinInformation(theAPI: doujin, doujinModel: doujinModel)
                })
                
                //                Loading circle
                if doujin.loadingCircle == true{
                    LoadingCircle(theApi: doujin)
                }
                
            }
            
        }
        .lineSpacing(0)
        .edgesIgnoringSafeArea(.all)


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


//struct DoujinView_Previews: PreviewProvider {
//    static var previews: some View {
//        DoujinView(doujin: DoujinAPI())
//    }
//}


