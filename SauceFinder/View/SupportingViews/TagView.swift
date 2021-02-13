//
//  TagView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 2/12/21.
//

import SwiftUI
import RealmSwift

struct TagView: View {
    
    var tagArray: RealmSwift.List<DoujinTags>
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(0..<tagArray.count) { tag in
                        Spacer()
                        
                        Text(tagArray[tag].Name)
                        //Adds a circular background behind the tags, not sure if it looks good?
//                            .background(RoundedRectangle(cornerRadius: 7).fill(Color.purple).shadow(radius: 2))

                        Spacer()
                    }
                }
            }
            .frame(height: 20 ,alignment: .center)
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tagArray: DoujinInfo().Tags)
    }
}

//Currently Useless 
struct Cicrcular:View{
    
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 200, height: 200)
            
            Text("Your desired text")
                .foregroundColor(.white)
        }
    }
}
