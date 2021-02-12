//
//  DoujinView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/2/20.
//

import SwiftUI
import RealmSwift

struct DoujinView: View {
    
    @ObservedObject var Doujin = DoujinAPI()
    @State private var Doujinshis: Results<DoujinInfo> = realm.objects(DoujinInfo.self)
    @State private var DetailViewShowing:Bool = false
    @State private var SelectedDoujin: DoujinInfo?
    
    var body: some View {
        if Doujinshis.count == 0 {
            //Code if there aren't doujins
            GeometryReader { Geometry in
                ZStack {
                    ScrollView(.vertical){
                        VStack(spacing:0){
                            Button(action: {
                                self.DetailViewShowing.toggle()
                            }){
                                DoujinCellWithNODoujin(ScreenSize: Geometry.size)
                                
                            }                        .sheet(isPresented: $DetailViewShowing, content: {
                                DoujinInformation(TheDoujin: self.$SelectedDoujin)
                                
                            })
                        }
                        
                        if Doujin.LoadingCirclePresent == true{
                            LoadingCircle(TheAPI: Doujin)
                                .padding(.top)
                        }
                    }
                }
                .offset(x: 300)
            }
        }
        if Doujinshis.count != 0{
            //Code if there are any Doujins
            GeometryReader{ Geometry in
                ZStack {
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            ForEach(Doujinshis, id: \.UniqueID) { Doujinshi in
                                Button(action: {
                                    self.DetailViewShowing = true
                                    self.SelectedDoujin = Doujinshi
                                    print("VIEW NOW")
                                }) {
                                    DoujinCell(TheImage: convertBase64ToImage(Doujinshi.PictureString), ScreenSize: Geometry.size)
                                }
                                
                                
                            }
                            .sheet(isPresented: $DetailViewShowing, content: {
//                                DoujinInformation(TheDoujin: self.$SelectedDoujin)
                                Text("peeepeepoopo")
                                
                            })
                            if Doujin.LoadingCirclePresent == true{
                                LoadingCircle(TheAPI: Doujin)
                                    .padding(.top)
                            }
                        }
                        
                    }
                    
                    .offset(x: 320)
                }
                
                .edgesIgnoringSafeArea(.all)
            }
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
