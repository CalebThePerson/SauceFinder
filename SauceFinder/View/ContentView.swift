//
//  ContentView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 11/30/20.
//

import SwiftUI
import RealmSwift
import MLKit



enum sheetPicker:Identifiable{
    var id: Int{
        hashValue
    }
    
    case addDoujin
    case imagePick
    case imageSauce
}

struct ContentView: View {
    
    @ObservedObject var doujin = DoujinAPI()
    @StateObject var viewRouter = ViewRouter()
    @StateObject var doujinModel = DoujinInfoViewModel()

    
    var sauceAPI = SauceNaoAPI()
    
    @State var showing:Bool = false
    
    @State var sheetPicker: sheetPicker? = .none
    @State private var InputImage: UIImage?
    @State var changeSheet = false
    
    var body: some View {
        GeometryReader {geo in
            
            ZStack {
                
                switch viewRouter.currentPage {
                case .sauce:
                    DoujinView(doujin: doujin)
                        .padding(.bottom, 50)
                case .hentai:
                    Text("HentaiView my guy")
                }
                VStack {
                    
                    Spacer()
                    
                    //Where we actually code the tab bar into play
                    HStack{
                        TabBarIcon(currentPage: $viewRouter.currentPage, width: 30, height: 30, systemIconName: "book", tabName: "Sauce", assignedPage: .sauce)
                            .padding(.trailing, 10)
                            .offset(y:-10)
                        
                        TabBarCircle(length: 50, showingViews: $showing, sheetPicker: $sheetPicker )
                            .offset(y: -40)
                        
                        TabBarIcon(currentPage: $viewRouter.currentPage, width: 30, height: 30, systemIconName: "plus", tabName: "Hentai", assignedPage: .hentai)
                            .padding(.leading, 10)
                            .offset(y:-10)
                    }
                    .padding(.bottom, 10)
                    .frame(width: geo.size.width, height: geo.size.height/8)
                    .background(Color("TabBarColor").shadow(radius:2))
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                
                .sheet(item: $sheetPicker){item in
                    switch item{
                    
                    //This case will open the addSauce view
                    case .addDoujin:
                        AddSauceView(DoujinApi: doujin, changeSheet: $changeSheet, isPresented: $showing)
                            .onDisappear(perform: {
                                //Once it disspaears it will run this function
                                sheet()
                            })
                        
                    //This case will open the image picture
                    case .imagePick:
                        ImagePicker(image: self.$InputImage)
                            .onDisappear(perform: {
                                LoadImage()
                            })
                        
                    //Opens the image picker however, it will do something different on dismisal
                    case .imageSauce:
                        ImagePicker(image: self.$InputImage)
                            .onDisappear(perform: {
                                guard let theImage = InputImage else {return}
                                doujin.loadingCircle = true
                                textRecog(the: doujin,with: theImage)
                            })
                        
                    }
                }
            }
        }
    }
    func LoadImage(){
        //Loads the image into a variable and then converts it into base 64 allowing it to be used by SauceNao api
        guard let InputImage = InputImage else {return}
        
        //Displays the loading circle
        doujin.loadingCircle = true
        convertImageToBase64(InputImage)
        self.InputImage = nil
    }
    
    
    func sheet(){
        //A function that changes the sheetPicker selectin based on a variable
        if changeSheet == true{
            sheetPicker = .imageSauce
        }
        changeSheet = false
        
    }
    func convertImageToBase64(_ image: UIImage) {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        sauceAPI.FindDoujin(with: doujin,imageString: strBase64)
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
                    .foregroundColor(Color("TabNames"))
                
                
                Text(tabName)
                    .font(.footnote)
                    .foregroundColor(Color("TabNames"))
            }
        }
    }
}
