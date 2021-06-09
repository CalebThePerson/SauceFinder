//
//  LoadingCircle.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 12/30/20.
//

import SwiftUI

struct LoadingCircle: View {
    
    //How we keep track of the indicator
    @State var Degrees = 0.0
    var theApi: DoujinAPI
    
    var body: some View {
        ZStack {
            //Creating an inner, static circle
            Circle()
                .stroke(Color.gray, lineWidth: 5.0)
                .frame(width: 120, height:120)
                .rotationEffect(Angle(degrees:-90))
            
            Text("\(theApi.progress)")
            
            //Create a dynamic circle dependent on teh degree state
            Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(Color.purple, lineWidth: 5.0)
                .frame(width:120, height:120)
                .rotationEffect(Angle(degrees: Degrees))
        }
        .frame(width: 90, height: 90)
        .onAppear(perform: {
            self.start()
        })
//        .padding(.bottom,500)
    }
}

struct LoadingCircle_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCircle(theApi: DoujinAPI())
    }
}



