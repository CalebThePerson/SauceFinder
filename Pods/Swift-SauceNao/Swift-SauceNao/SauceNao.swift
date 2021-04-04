//
//  SauceNao.swift
//  Swift-SauceNao
//
//  Created by Jaquet Vincent on 14.02.19.
//  Copyright © 2019 Vinrobot. All rights reserved.
//

import Foundation
import Alamofire

public class SauceNao {

	public typealias CompletionBlock = (SauceNaoResult?, Error?) -> Void

	public static let defaultUrl: URL = URL(string: "https://saucenao.com/search.php")!
	public static let defaultNumres: UInt = 16
	public static let defaultDatabaseId: String = "999"

	private let apiKey: String
	private let testmode: String
	private let skipLimiters: Bool

	public init(apiKey: String, testmode: Bool = false, skipLimiters: Bool = true) {
		self.apiKey = apiKey
		self.testmode = testmode ? "1" : "0"
		self.skipLimiters = skipLimiters
	}

	public func search(url: URL, db: Database, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.search(url: url.absoluteString, db: String(db.id), numres: numres, completion: completion)
	}

	public func search(url: URL, db: String = SauceNao.defaultDatabaseId, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.search(url: url.absoluteString, db: db, numres: numres, completion: completion)
	}

	public func search(url: String, db: Database, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.search(url: url, db: String(db.id), numres: numres, completion: completion)
	}

	public func search(url: String, db: String = SauceNao.defaultDatabaseId, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.doSearch(db, numres, formData: { (form) in
			form.append(url, withName: "url")
		}, completion: completion)
	}

	public func search(data: Data, fileName: String, mimeType: String, db: Database, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.search(data: data, fileName: fileName, mimeType: mimeType, db: String(db.id), numres: numres, completion: completion)
	}

	public func search(data: Data, fileName: String, mimeType: String, db: String = SauceNao.defaultDatabaseId, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.doSearch(db, numres, formData: { (form) in
			form.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
		}, completion: completion)
	}

	public func search(file: URL, db: Database, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.search(file: file, db: String(db.id), numres: numres, completion: completion)
	}

	public func search(file: URL, db: String = SauceNao.defaultDatabaseId, numres: UInt = SauceNao.defaultNumres, completion: @escaping CompletionBlock) {
		self.doSearch(db, numres, formData: { (form) in
			form.append(file, withName: "file")
		}, completion: completion)
	}

	private func checkLimiters() -> Bool {
		if !self.skipLimiters {
			guard Limiter.longLimiter.canExecute() else {
				return false
			}
			guard Limiter.shortLimiter.canExecute() else {
				Limiter.longLimiter.cancelExecute()
				return false
			}
		}
		return true
	}

	private func doSearch(_ db: String, _ numres: UInt, formData: @escaping (MultipartFormData) -> Void, completion: @escaping CompletionBlock, checkLimiter check: Bool = true) {
		guard check || self.checkLimiters() else {
			completion(nil, LimiterError.rateLimited)
			return
		}

		var urlcp = URLComponents(url: SauceNao.defaultUrl, resolvingAgainstBaseURL: false)!
		urlcp.queryItems = [ URLQueryItem(name: "numres", value: String(numres)), URLQueryItem(name: "db", value: db) ]
		urlcp.percentEncodedQuery = urlcp.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
		var request = URLRequest(url: urlcp.url!)
		request.httpMethod = "POST"
		let queue = DispatchQueue(label: "request")
		Session.default.upload(multipartFormData: { (form) in
			form.append(self.apiKey, withName: "api_key")
			form.append("2", withName: "output_type")
			form.append(self.testmode, withName: "testmode")
			form.append(String(numres), withName: "numres")
			form.append(db, withName: "db")
			//form.append("0", withName: "dbmask")
			//form.append("0", withName: "dbmaski")
			formData(form)
		}, with: request).validate().responseJSON(queue: queue) { (response) in
			do {
				let value = try response.result.get()
				let result = try SauceNaoResult.parse(data: value)
				let limits = result.limits
				if (limits.longRemaining >= 0) {
					Limiter.longLimiter.setCount(UInt(limits.longLimit - limits.longRemaining))
				}
				if (limits.shortRemaining >= 0) {
					Limiter.longLimiter.setCount(UInt(limits.shortLimit - limits.shortRemaining))
				}
				completion(result, nil)
			} catch {
				completion(nil, error)
			}
		}
	}
}
