//
//  SauceNao.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 4/4/21.
//

import Foundation
import Swift_SauceNao

class SauceNaoAPI{
//    var theApiKey = "39c06c99f48a6c895c979ed0509251812547441b"
    let saucenao = SauceNao(apiKey: "39c06c99f48a6c895c979ed0509251812547441b")
    let doujinAPI = DoujinAPI()
    
    func FindDoujin(imageString: String){
        print("running")
        let image = convertBase64ToImage(imageString)
        let imageData = image.pngData()
        let fileName = "image.jpg"
        let mimeType = "image/jpeg"
        var englishName = ""
        var similarity = ""
        
        saucenao.search(data: imageData!, fileName: fileName, mimeType: mimeType) {(result, error) in
            print("step one")
            if let theResults = result?.results?[0]{
                print("Next steep")
                englishName = theResults.eng_name!
                similarity = "\(theResults.similarity)"
                englishName = englishName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                self.doujinAPI.bookInfoWithName(with: englishName, the: similarity)

            }
        }

    }
}

extension SauceNaoAPI{
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
}
