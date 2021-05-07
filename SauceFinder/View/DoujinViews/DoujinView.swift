//
//  DoujinView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/2/20.
//

import SwiftUI
import RealmSwift
import Combine

struct DoujinView: View {
    
    @ObservedObject var doujin: DoujinAPI
    //    @ObservedResults(DoujinInfo.self) var doujinshis
    @State private var detailViewShowing: Bool = false
    @State private var selectedDoujin: DoujinInfo?
    @State var alertShow:Bool = false
    @State var testing:Bool = DoujinAPI().removing
    @StateObject var doujinModel = DoujinInfoViewModel()

    
    @State static var loading:Bool = false
    
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
        //The Alert that doesn't work
        .alert(isPresented: $doujin.cantfindAlert){
            Alert(title: Text("Sorry"), message: Text("Couldn't find that Sauce"), dismissButton: .default(Text("Dismiss")))
        }
        .lineSpacing(0)
        
        .edgesIgnoringSafeArea(.all)
    }
}

struct DoujinView_Previews: PreviewProvider {
    static var previews: some View {
        DoujinView(doujin: DoujinAPI())
    }
}


