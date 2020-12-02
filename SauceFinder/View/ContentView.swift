//
//  ContentView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 11/30/20.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var Doujin = DoujinAPI()
    
    var body: some View {
        GeometryReader { geo in
            Text("Mas Drogas")
            Button(action:{
                self.Doujin.bookInfo(SauceNum: "177013")
            }) {
                Text("COggers")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
