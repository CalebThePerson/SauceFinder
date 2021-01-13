//
//  TabBarCircle.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/12/21.
//

import SwiftUI

struct TabBarCircle: View {
    var Width, Height: CGFloat
    @State var ShowPopUp = false
    
    var body: some View {
        ZStack {
            if ShowPopUp {
                PlusMenu(widthAndHeight: Width/7)
                    .offset(y: -Height/6)
            }
            
            
            HStack {
                ZStack{
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: Width/7, height: Width/7)
                                        .shadow(radius:4)
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Width/7-6, height: Width/7-6)
                        .foregroundColor(Color("DarkPurple"))
                        .rotationEffect(Angle(degrees: ShowPopUp ? 90 : 0))
                }
            }
        }
        //        .offset(y: -Height/8/2)
        .onTapGesture {
            withAnimation {
                ShowPopUp.toggle()
            }
        }
    }
}

struct TabBarCircle_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geo in
            TabBarCircle(Width: geo.size.width, Height: geo.size.height)
            
        }
    }
}

struct PlusMenu: View {
    
    let widthAndHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 50) {
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
            ZStack {
                Circle()
                    .foregroundColor(Color("DarkPurple"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "minus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
        }
        .transition(.scale)
    }
}
