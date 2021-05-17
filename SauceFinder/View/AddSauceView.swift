//
//  AddSauceView.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 2/11/21.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI


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
                                FloatingLabelTextField($InputDoujin, placeholder: "Sauce", editingChanged: { (isChanged) in
                                    
                                }) {
                                    
                                }

                                .leftView({
                                    Image(systemName: "book")
                                })
                                .isShowError(true)
                                .textColor(.green)
                                .addValidations([.init(condition: InputDoujin.isValid(.number), errorMessage: "Invalid Sauce"),
                                                     .init(condition: InputDoujin.count <= 6, errorMessage: "Maximum is 6 letters")
                                    ])
                                .floatingStyle(ThemeTextFieldStyle2())
                                .frame(height: 70)
                                
                            
                                
//                                TextField("Numbers Here", text: $InputDoujin)
//                                    .keyboardType(.numberPad)
                            }
                            //If it is more than 6 digits, it will prompt this
                            else{
//                                TextField("Under 6 Digits Sped", text:$InputDoujin)
//                                    .keyboardType(.numberPad)
                            }
                            
                            //Button to iniate the search
                            VStack{
                                Button(action: {
                                    if self.CheckLength(Numbers: InputDoujin) == true {
                                        

                                        DoujinApi.loadingCircle = true

                                        isPresented.toggle()
                                        presentationMode.wrappedValue.dismiss()

                                        DispatchQueue.background(background: {
                                            //Does something in background
                                            DoujinApi.bookInfo(Sauces: [InputDoujin])

                                        }, completion: {
                                            //When the task finally completes it updates the published var
                                            DoujinApi.loadingCircle = false

                                        })
                                        
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


struct ThemeTextFieldStyle2: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.selectedTitleColor(.green).errorColor(.init(UIColor.red)).selectedTextColor(.green).selectedLineColor(.green)
    }
}
