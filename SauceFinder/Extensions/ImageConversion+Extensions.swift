//
//  ImageConversion+Extensions.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/5/21.
//

import Foundation
import SwiftUI

public func convertBase64ToImage(_ str: String) -> UIImage {
    let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
    let decodedimage = UIImage(data: dataDecoded)
    return decodedimage!
}

public func convertImageToBase64(_ image: UIImage)-> String {
    let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
    let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
    return strBase64
}
