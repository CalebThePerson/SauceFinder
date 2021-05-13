//
//  SwipeDeleteRow.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/12/21.
//

import SwiftUI

struct SwipeDeleteRow<Content: View>: View {
    
    private let content: () -> Content
    private let deleteAction: () -> ()
    private var isSelected: Bool
    @Binding private var selectedIndex: Int
    private var index: Int
    
    init(isSelected: Bool, selectedIndex: Binding<Int>, index: Int, @ViewBuilder content: @escaping () -> Content, onDelete: @escaping () -> Void) {
        self.isSelected = isSelected
        self._selectedIndex = selectedIndex
        self.content = content
        self.deleteAction = onDelete
        self.index = index
    }
    
    @State private var offset = CGSize.zero
    @State private var offsetY : CGFloat = 0
    @State private var scale : CGFloat = 0.5
    
    var body : some View {
        HStack(spacing: 0){
            content()
                .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            
            Button(action: deleteAction) {
                Image(systemName: "trash.circle")
//                    .renderingMode(.original)
                                .resizable()
                    .foregroundColor(.red)
                    .frame(width:25, height: 25)
                
            
            }
            .padding(.leading,10)
            .onTapGesture {
                print("cool")
            }
        }
        .background(Color.white)
        .offset(x: 20, y: 0)
        .offset(isSelected ? self.offset : .zero)
        .animation(.spring())
        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                    .onChanged { gestrue in
                        self.offset.width = gestrue.translation.width
                        print(offset)
                        print(index)
                    }
                    .onEnded { _ in
                        self.selectedIndex = index
                        if self.offset.width < -50 {
                            self.scale = 1
                            self.offset.width = -60
                            self.offsetY = -20
                        } else {
                            self.scale = 0.5
                            self.offset = .zero
                            self.offsetY = 0
                            
                        }
                    }
        )
    }
}

//struct SwipeDeleteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SwipeDeleteRow()
//    }
//}
