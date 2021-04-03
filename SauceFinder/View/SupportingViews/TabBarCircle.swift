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
    @Binding var additionShowing:Bool
    @Binding var delete: Bool
    
    var body: some View {
        ZStack {
            if showPopUp {
                PlusMenu(widthAndHeight: length, ShowOne: $additionShowing, ShowTwo: $delete)
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
        
        TabBarCircle(length: 50, additionShowing: .constant(false), delete: .constant(false))
        
    }
}

struct PlusMenu: View {
    
    let widthAndHeight: CGFloat
    @Binding var ShowOne: Bool
    @Binding var ShowTwo: Bool
    @ObservedObject var doujinApi = DoujinAPI()

    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Button(action: {
                    self.ShowOne.toggle()
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

                doujinApi.removing.toggle()
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
