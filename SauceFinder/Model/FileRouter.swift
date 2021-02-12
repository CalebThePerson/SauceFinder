//
//  FileRouter.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 1/12/21.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject{
    @Published var currentPage: Page = .sauce
}

enum Page {
    case sauce
    case hentai
}
