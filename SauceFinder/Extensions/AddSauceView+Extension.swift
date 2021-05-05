//
//  AddSauceView+Extension.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/5/21.
//

import Foundation

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
