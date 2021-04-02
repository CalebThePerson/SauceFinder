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
                        DoujinInformation(theDoujin: $selectedDoujin)
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

                    .sheet(isPresented: $detailViewShowing, content: {
                        DoujinInformation(theDoujin: $selectedDoujin)
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
    
    func PrintTheThing(Doujin: DoujinInfo){
        print(Doujin.Name)
    }
}
