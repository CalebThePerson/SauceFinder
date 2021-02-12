//
//  AddDoujin.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/3/20.
//

import SwiftUI

struct AddDoujin: View {
    @State private var InputDoujin:String = ""
    var DoujinApi:DoujinAPI
    @Binding var isPresented:Bool
    @State private var RedoEntry:Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Form {
                    //                    Section {
                    Text("Enter The Sauce:")
                    
                    //If It doesn't need to be redone aka when it starts up it will prompt this text field
                    if RedoEntry == false {
                        TextField("Enter the Sauce Degen", text:$InputDoujin, onCommit: {
                            UIApplication.shared.keyWindow?.endEditing(true)
                        })
                        .keyboardType(.numberPad)
                    }
                    //This will only be prompted when it over 6 digits, which will tell the user to redo it
                    else{
                        TextField("Under 6 Digits Sped", text:$InputDoujin, onCommit: {
                            
                        }).keyboardType(.numberPad)
                    }
                    
                    //                        }
                    //The button checks if it needs to be redone or not
                    //If it doesnt it closes the sheet while also calling the api
                    VStack{
                        Spacer()
                        Button(action: {
                            if CheckLength(Numbers: InputDoujin) == true {
                                DoujinApi.bookInfo(SauceNum: InputDoujin);self.isPresented.toggle()
                            } else {
                                //If it requires to be redone it sets the variable to true and clear the textfield prompting the user to renter because of the issue
                                RedoEntry = true
                                InputDoujin = ""
                            }
                            
                        }){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("DarkPurple"))
                                    .frame(width: 80, height: 80)
                                
                                Text("Search")
                            }
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                
//                .buttonStyle(PlainButtonStyle())
            }
//            .frame(width: geo.size.width, height: geo.size.height/2)
            //                .navigationTitle(Text("Searching For?"))
            //            }
        }
        
    }
}

struct AddDoujin_Previews: PreviewProvider {
    static var previews: some View {
        AddDoujin(DoujinApi: DoujinAPI(), isPresented: .constant(false))
    }
}

extension AddDoujin {
    
    //Function to check the length , in order to decide if the user needs to redo it or not
    func CheckLength(Numbers:String)-> Bool {
        if Numbers.count == 0 {
            return false
        } else if Numbers.count < 6{
            return true
        }
        else if Numbers.count == 6{
            return true
        }
        else{
            return false
        }
    }
}
