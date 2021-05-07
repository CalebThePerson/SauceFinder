//
//  SauceNao.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 4/4/21.
//

import Foundation
import SwiftPackage_SauceNao
import SwiftUI

class SauceNaoAPI{
//    var theApiKey = "39c06c99f48a6c895c979ed0509251812547441b"
    let saucenao = SauceNao(apiKey: "39c06c99f48a6c895c979ed0509251812547441b")
    var doujinAPI = DoujinAPI()
    
    func FindDoujin(imageString: String){
        print("running")
        let image = convertBase64ToImage(imageString)
        let imageData = image.pngData()
        let fileName = "image.jpg"
        let mimeType = "image/jpeg"
        var englishName = ""
        var similarity = ""
        
        //Converts the picture into base64 and then runs it through the SauceNao API
        saucenao.search(data: imageData!, fileName: fileName, mimeType: mimeType) {(result, error) in
            if let theResults = result?.results?[0]{
                guard var englishName = theResults.eng_name else {return}
//                englishName = theResults.eng_name!
                similarity = "\(theResults.similarity)"
                print(englishName)
                englishName = englishName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                self.doujinAPI.bookInfoWithName(with: englishName, the: similarity)

            }
        }

    }
}

