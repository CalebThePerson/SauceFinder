//
//  TabBarCircle.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/12/21.
//

import SwiftUI

struct TabBarCircle: View {
    var length: CGFloat
    @State var showPopUp = false
    @Binding var showingViews:Bool
    @Binding var sheetPicker: sheetPicker?
    
    var body: some View {
        ZStack {
            if showPopUp {
                PlusMenu(widthAndHeight: length, show: $showingViews, sheet: $sheetPicker, showPopUp: $showPopUp)
                    .offset(y: -length)
                    
            }
            
            
            HStack {
                ZStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: length, height: length)
                        .shadow(radius:4)
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: length, height: length)
                        .foregroundColor(Color("DarkPurple"))
                        .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                }
            }
        }
        
        .onTapGesture {
            withAnimation {
                showPopUp.toggle()
            }
        }
    }
}

struct TabBarCircle_Previews: PreviewProvider {
    static var previews: some View {
        
        TabBarCircle(length: 50, showingViews: .constant(false), sheetPicker: .constant(sheetPicker.addDoujin))
        
    }
}

struct PlusMenu: View {
    
    let widthAndHeight: CGFloat
    @Binding var show: Bool
    @ObservedObject var doujinApi = DoujinAPI()
    @Binding var sheet: sheetPicker?
    @Binding var showPopUp: Bool


    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Button(action: {
                    self.sheet = .addDoujin
                    self.show.toggle()
                    self.showPopUp.toggle()
                }){
                    ZStack {
                        Circle()
                            .foregroundColor(Color("DarkPurple"))
                            .frame(width: widthAndHeight, height: widthAndHeight)
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(15)
                            .frame(width: widthAndHeight, height: widthAndHeight)
                            .foregroundColor(.white)
                    }
                }
            }
            Button(action: {

                self.sheet = .imagePick
                self.show.toggle()
                self.showPopUp.toggle()
            }){
                ZStack {
                    Circle()
                        .foregroundColor(Color("DarkPurple"))
                        .frame(width: widthAndHeight, height: widthAndHeight)
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.white)
                }
            }
            
        }
        .transition(.scale)
    }
}
