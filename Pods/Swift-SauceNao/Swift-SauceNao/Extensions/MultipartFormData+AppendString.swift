//
//  MultipartFormData+AppendString.swift
//  Swift-SauceNao
//
//  Created by Jaquet Vincent on 27.02.19.
//  Copyright © 2019 Vinrobot. All rights reserved.
//

import Foundation
import Alamofire

public extension MultipartFormData {

    func append(_ str: String, withName name: String) {
		self.append(str.data(using: .utf8)!, withName: name)
	}
}
