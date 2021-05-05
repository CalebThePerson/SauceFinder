//
//  DoujinAPI+Extension.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/5/21.
//

import Foundation
import AlamofireImage
import Alamofire

extension DoujinAPI{
    //The Function that grabs the picture of the sauce
    func getPitcture(Media: String,completion: @escaping (String) -> Void){
        
        var ImageString = ""
        
        AF.request("https://t.nhentai.net/galleries/\(Media)/cover.jpg").responseImage { response in
            
            if case .success(let image) = response.result {
//                print("Image downlaoded \(image)")
                
                ImageString = convertImageToBase64(image)
                completion(ImageString)
                
            }
        }
    }
    
}
