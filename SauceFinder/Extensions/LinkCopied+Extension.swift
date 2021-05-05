//
//  LinkCopied+Extension.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/5/21.
//

import Foundation
import SwiftUI


extension LinkCopied{
     func msgShown(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            showing = false
        }
    }
}
