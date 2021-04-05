//
//  DoujinView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/2/20.
//

import SwiftUI
import RealmSwift

struct DoujinView: View {
    
    @ObservedObject var doujin = DoujinAPI()
    @State private var doujinshis: Results<DoujinInfo> = realm.objects(DoujinInfo.self)
    @State private var detailViewShowing: Bool = false
    @State private var selectedDoujin: DoujinInfo?
    @State var alertShow:Bool = false
    @State var testing:Bool = DoujinAPI().removing
    
    
    var body: some View {
        
        if doujinshis.count == 0 {
            //Code if there aren't doujins
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Button(action: {
                        self.detailViewShowing.toggle()
                    }){
                        DoujinCellWithNODoujin()
                        
                    }
                    .sheet(isPresented: $detailViewShowing, content: {
                        DoujinInformation(theDoujin: $selectedDoujin, theAPI: doujin)
                    })
                }
                
                if doujin.loadingCirclePresent == true{
                    LoadingCircle(TheAPI: doujin)
                        .padding(.top)
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        } else {
            //Code if there are any Doujins
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(doujinshis, id: \.UniqueID) { doujinshi in
                        Button(action: {
                            self.detailViewShowing = true
                            self.selectedDoujin = doujinshi
                        }) {
                            DoujinCell(image: convertBase64ToImage(doujinshi.PictureString))
                        }
                    }

                    //This will ask if the user is sure they would like to delete the curent sauce
                    .alert(isPresented: $alertShow){
                        Alert(title: Text("Would you like to delete this entry"),message: Text(selectedDoujin!.Name),dismissButton:
                                .default(Text("Delete")) {
                                    SauceFinder.delete(doujin: selectedDoujin!)
                                })
                    }
                    
                    //This will preseent the sheet that displays information for the doujin
                    .sheet(isPresented: $detailViewShowing, onDismiss: {if doujin.removing == true {BigDelete(doujin: selectedDoujin!)}}, content: {
                        DoujinInformation(theDoujin: $selectedDoujin, theAPI: doujin)
                    })
                    
                    if doujin.loadingCirclePresent == true{
                        LoadingCircle(TheAPI: doujin)
                            .padding(.top)
                    }
                }
            }
            .lineSpacing(0)
            
            .edgesIgnoringSafeArea(.all)
        }
        
    }
    //Code that may be helpful later when deleting multiple rows
    func deleteRow(with indexSet: IndexSet){
        indexSet.forEach ({ index in
            try! realm.write {
                realm.delete(self.doujinshis[index])
            }
        })
    }
}

struct DoujinView_Previews: PreviewProvider {
    static var previews: some View {
        DoujinView()
    }
}

extension DoujinView {
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    func BigDelete(doujin: DoujinInfo){
        do {
            try realm.write{
                realm.delete(doujin)
            }
        }
        catch {
            print("There was an error \(error)")
        }
        print("Deleted")
        self.doujinshis = realm.objects(DoujinInfo.self)
    }
    
}
