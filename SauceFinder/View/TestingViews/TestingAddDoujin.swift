//
//  TestingAddDoujin.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/13/21.
//

import SwiftUI

struct TestingAddDoujin: View {
    var DoujinApi:DoujinAPI
    @Binding var isPresented:Bool
    var PickerOptions = ["Doujin", "Hentai"]
    @State var PickerSelected = ""
    @State var CurrentSelectionForPicker = 0
    
    //Vaiables for theAddDoujin view
    
    @State private var RedoEntry:Bool = false
    @State private var InputDoujin:String = ""
    
    
    
    //Add Doujin variables
    
    
    var body: some View {
        GeometryReader { geo in
            NavigationView{
                VStack {
                    //Creating a section where we ask the user if they will be adding hentai or doujin
                    //                    VStack{
                    Form{
                        Section(header: Text("What you you looking for?")) {
                            Picker(selection: $CurrentSelectionForPicker, label: Text("Please select one")) {
                                ForEach(0..<PickerOptions.count) {
                                    Text("\(self.PickerOptions[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        
                        //Displays a view specific for adding Doujin
                        if CurrentSelectionForPicker == 0 {
                            Section(header:Text("Sauce Details")){
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
                                .offset(x:100)
                            }
                        }
                        else{
                            Section(header: Text("Hentai Picture ")){
                                Text("Yuh")
                            }
                        }
                    }
                }
                
                
                
                
                
            }
            
        }
    }
}


struct TestingAddDoujin_Previews: PreviewProvider {
    static var previews: some View {
        TestingAddDoujin(DoujinApi: DoujinAPI(), isPresented: .constant(false))
    }
}

extension TestingAddDoujin {
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

