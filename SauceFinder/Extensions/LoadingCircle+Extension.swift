//
//  LoadingCircle+Extension.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 5/5/21.
//

import Foundation
import SwiftUI

extension LoadingCircle{
    func start() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (timer) in
            withAnimation{
                self.Degrees += 10.0
            }
            if self.Degrees == 360.0 {
                self.Degrees = 0
            }
        })
    }
}
