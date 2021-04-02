//
//  ContentView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 11/30/20.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var doujin = DoujinAPI()
    @StateObject var viewRouter = ViewRouter()
    @State var addDoujinShow: Bool = false
    @State var removal: Bool = false
    
    var body: some View {
        ZStack {
            switch viewRouter.currentPage {
            case .sauce:
                DoujinView()
            case .hentai:
                Text("HentaiView my guy")
            }
            
            VStack {

                Spacer()

                /// Where we actually code the tab bar into play
                HStack{
                    TabBarIcon(currentPage: $viewRouter.currentPage, width: 30, height: 30, systemIconName: "book", tabName: "Sauce", assignedPage: .sauce)
                        .padding(.trailing, 10)

                    TabBarCircle(length: 50, additionShowing: $addDoujinShow, delete: $removal)
                        .offset(y: -20)

                    TabBarIcon(currentPage: $viewRouter.currentPage, width: 30, height: 30, systemIconName: "plus", tabName: "Hentai", assignedPage: .hentai)
                        .padding(.leading, 10)
                }

            }
            .sheet(isPresented: $addDoujinShow, content: {
                AddSauceView(DoujinApi: doujin, isPresented: $addDoujinShow)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabBarIcon: View {
    @Binding var currentPage: Page
    
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    let assignedPage: Page
    
    var body: some View {
        
        Button(action: {
            currentPage = assignedPage
        }) {
            VStack{
                Image(systemName: systemIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                
                Text(tabName)
                    .font(.footnote)
            }
        }
    }
}
