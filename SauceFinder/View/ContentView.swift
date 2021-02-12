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
    @StateObject var viewRouter: ViewRouter
    @State var AddDoujinShow:Bool = false
    @State var Removal: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center){
                Spacer()
                
                switch viewRouter.currentPage {
                case .Sauce:
                    VStack(alignment:.center){
                        DoujinView(Doujin: Doujin)
                    }
                //                    .offset(x: -500)
                case .Hentai:
                    Text("HentaiView my guy")
                }
                Spacer()
                
                //Where we actually code the tab bar into play
                HStack{
                    TabBarIcon(width: geo.size.width/2, height: geo.size.height/28, systemIconName: "book", tabName: "Sauce", viewRouter: viewRouter, assignedPage: .Sauce)
                    ZStack{
                        TabBarCircle(Width: geo.size.width, Height: geo.size.width, AdditionShowing: $AddDoujinShow, Delete: $Removal)
                    }
                    .offset(y:-geo.size.height/8/3)
                    
                    TabBarIcon(width: geo.size.width/2, height: geo.size.height/28, systemIconName: "plus", tabName: "Hentai", viewRouter: viewRouter, assignedPage: .Hentai)
                }
                
                .frame(width: geo.size.width, height: geo.size.height/8)
                .background(Color("Background").shadow(radius:2))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $AddDoujinShow, content: {
            AddSauceView(DoujinApi: Doujin, isPresented: $AddDoujinShow)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

struct TabBarIcon: View{
    let width, height: CGFloat
    let systemIconName, tabName: String
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    
    var body: some View {
        VStack{
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
    }
}
