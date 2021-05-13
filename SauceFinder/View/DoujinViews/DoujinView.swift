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
    
    @State private var listCellIndex:Int = 0
    
    
    //Change this to @StateObject ?/
    @StateObject var doujinModel = DoujinInfoViewModel()
    var body: some View {
        //Code if there are any Doujins
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                //doujinModel.doujins.indicies / index
                ForEach(doujinModel.doujins){ doujinshi in
                    
                    SwipeDeleteRow(isSelected: doujinModel.doujins.index(of: doujinshi) == listCellIndex, selectedIndex: $listCellIndex, index: doujinModel.doujins.index(of: doujinshi)!){
                        
                        if doujinshi.isInvalidated == false{
                                                    DoujinCell(image: convertBase64ToImage(doujinshi.PictureString))

                        }
                    } onDelete:{
                        doujinModel.easyDelete(at: doujinModel.doujins.index(of: doujinshi)!)
                        listCellIndex = -1
                    }
                    //                    SwipeDeleteRow(isSelected: index == listCellIndex, selectedIndex: $listCellIndex, index: index){
                    //                        if let item = doujinModel.doujins[index]{
                    ////                            DoujinCell(image: convertBase64ToImage(item.PictureString))
                    //                            Text("Pog")
                    //
                    //                        }
                    //                    }onDelete:{
                    //                        doujinModel.easyDelete(at: index)
                    //                        listCellIndex = 1
                    //                    }
                    //                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    //                    Button(action: {
                    //                        self.detailViewShowing = true
                    //                        self.doujinModel.selectedDoujin = doujinshi
                    //
                    //                    }) {
                    //                    }
                }
                
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
//        .edgesIgnoringSafeArea(.all)
        
        
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


//struct Model: Identifiable {
//    var id = UUID()
//}
//
//struct CustomSwipeDemo: View {
//
//    @State var arr: [Model] = [.init(), .init(), .init(), .init(), .init(), .init(), .init(), .init()]
//
//    @State private var listCellIndex: Int = 0
//
//    var body: some View {
//        ScrollView(.vertical) {
//            LazyVStack(spacing: 0) {
//                ForEach(arr.indices, id: \.self) { index in
//                    SwipeDeleteRow(isSelected: index == listCellIndex, selectedIndex: $listCellIndex, index: index) {
//                        if let item = self.arr[safe: index] {
//                            Text(item.id.description)
//                        }
//                    } onDelete: {
//                        arr.remove(at: index)
//                        self.listCellIndex = -1
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                }
//            }
//        }
//    }
//}
