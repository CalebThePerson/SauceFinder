//
//  AddSauceView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 2/11/21.
//

import SwiftUI


struct AddSauceView: View {
    var DoujinApi:DoujinAPI

    //Strings for the pickers
    var PickerOptions = ["Doujin", "Hentai"]
    var secondPicker = ["Manual", "Pictures"]
    
    //@States for ubdating pickers and the selections
    @State var secondPickerSelected = ""
    @State var PickerSelected = ""
    @State var CurrentSelectionForPicker = 0
    @State var currentSelectionforSecond = 0

    @State private var RedoEntry:Bool = false
    @State private var InputDoujin:String = ""
    
    //Variables from the contentView
    @Binding var changeSheet: Bool
    @Binding var isPresented:Bool
    
    //Var that we can use to instantly dismiss the view from inside
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        VStack{
            Form{
                //This code is for the picker between Doujin and Hentai
                Section(header:Text("What are you looking for?")) {
                    Picker(selection: $CurrentSelectionForPicker, label: Text("Please select one")){
                        ForEach(0..<PickerOptions.count){
                            Text("\(self.PickerOptions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                //If Doujin is selected
                if CurrentSelectionForPicker == 0 {
                    Section(header: Text("Sauce Details")){
                        Picker(selection: $currentSelectionforSecond, label: Text("Select one")){
                            ForEach(0..<secondPicker.count){
                                Text("\(self.secondPicker[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    //If Manual is selected
                    if currentSelectionforSecond == 0{
                        Section(header: Text("Sauce Details")){
                            Text("Enter the Sauce")
                            
                            if RedoEntry == false{
                                TextField("Numbers Here", text: $InputDoujin)
                                    .keyboardType(.numberPad)
                            }
                            //If it is more than 6 digits, it will prompt this
                            else{
                                TextField("Under 6 Digits Sped", text:$InputDoujin)
                                    .keyboardType(.numberPad)
                            }
                            
                            //Button to iniate the search
                            VStack{
                                Button(action: {
                                    if CheckLength(Numbers: InputDoujin) == true {
                                        DoujinApi.bookInfo(Sauces: [InputDoujin]);self.isPresented.toggle();presentationMode.wrappedValue.dismiss()
                                        
                                    } else {
                                        //If it requires to be redone it sets the variable to true and clear the textfield prompting the user to renter because of the issue
                                        RedoEntry = true
                                        InputDoujin = ""
                                    }
                                    
                                }){
                                    ZStack {
                                        Circle()
                                            .foregroundColor(Color("DarkPurple"))
                                            .frame(height: 80)
                                            .ignoresSafeArea()
                                        
                                        Text("Search")
                                    }
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .frame(alignment: .center)
                            
                            
                        }
                    }
                    
                    
                    
                    //If pictures is selected
                    if currentSelectionforSecond == 1{
                        //This will close the current sheet and open up imagepicker
                        Text("Opening")
                            .onAppear(perform: {
                                print("noticed")
                                changeSheet = true
                                presentationMode.wrappedValue.dismiss()
                                print("kewl")
                            })
                    }
                    
                    
                    
                    
                }
            }
        }
        
    }
}
struct AddSauceView_Previews: PreviewProvider {
    static var previews: some View {
        AddSauceView(DoujinApi: DoujinAPI(), changeSheet: .constant(false), isPresented: .constant(false))
    }
}

extension AddSauceView{
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
