//
//  ContentView+Extension.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/5/21.
//

import Foundation
import MLKit

extension ContentView {
    func textRecog(with InputImage: UIImage?){        
        //Function that takes care of all of the text recognition of the numbers then passes it to the API
        guard let InputImage = InputImage else {return}
        
        let image = VisionImage(image: InputImage)
        var sauceFound = [String]()
        
        let textRecognizer = TextRecognizer.textRecognizer()
        textRecognizer.process(image){ result, error in
            guard error == nil, let result = result else{
                print("error: \(String(describing: error))")
                return
            }
            
            for block in result.blocks{
                for line in block.lines{
                    for element in line.elements{
                        let elementText = element.text
                        if (Int(elementText) != nil) {
                            print(elementText)
                            sauceFound.append(elementText)
                        }
                    }
                }
            }
            print("running")
            
            
            doujin.bookInfo(Sauces: sauceFound)
            changeSheet = false
        }
        
        
    }
}
