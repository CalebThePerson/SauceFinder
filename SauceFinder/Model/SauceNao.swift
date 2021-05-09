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
    
    func FindDoujin(with api: DoujinAPI,imageString: String){
        print("running")
        let image = convertBase64ToImage(imageString)
        let imageData = image.pngData()
        let fileName = "image.jpg"
        let mimeType = "image/jpeg"
        var similarity = ""
        
        //Converts the picture into base64 and then runs it through the SauceNao API
        saucenao.search(data: imageData!, fileName: fileName, mimeType: mimeType) {(result, error) in
            print("skadosh")
            if let theResults = result?.results?[0]{
                print(type(of: theResults))
                print("here")
                guard var englishName = theResults.eng_name else {api.loadingCircle = false;api.activeAlert = .noSauce;api.showAlert.toggle();return}
                //                englishName = theResults.eng_name!
                similarity = "\(theResults.similarity)"
                print(englishName)
                englishName = englishName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                
                //Making the API call in the background and when it's done it updates to make the loading circle turn off
                DispatchQueue.background(background: {
                    //Does something in background
                    self.doujinAPI.bookInfoWithName(with: englishName, the: similarity)
                }, completion: {
                    //When the task finally completes it updates the published var
                    sleep(2)
                    api.loadingCircle = false
                })
                
                
                
            }
        }
        
    }
}

