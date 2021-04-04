//
// SauceNaoResult.swift
// Swift-SauceNao
//
// Created by Jaquet Vincent on 27.02.19.
// Copyright © 2019 Vinrobot. All rights reserved.
//

import Foundation

public enum ResultParseError: Error {
	case unexpectedResponse(value: Any?)
	case missingHeader(header: String)
}

internal class Parser {

	internal static func toDouble(_ obj: Any?) -> Double? {
		if let num = obj as? Double {
			return num
		} else if let obj = obj as? String, let num = Double(obj) {
			return num
		}
		return nil
	}

	internal static func toInt(_ obj: Any?) -> Int? {
		if let num = obj as? Int {
			return num
		} else if let obj = obj as? String, let num = Int(obj) {
			return num
		}
		return nil
	}

	internal static func toArray<T>(_ obj: Any?) -> [T]? {
		if let array = obj as? [T] {
			return array
		} else if let item = obj as? T {
			return [item]
		}
		return nil
	}
}

public struct SauceNaoResult {

	// header
	public let header: [String: Any]

	// header.status
	public let status: Int
	// header.message
	public let message: String?

	public let limits: Limits
	public let account: Account?
	public let info: ResultsInfo?

	// results
	public let results: [Result]?

	internal static func parse(data obj: Any?) throws -> SauceNaoResult {
		guard let data = obj as? [String: Any] else {
			throw ResultParseError.unexpectedResponse(value: obj)
		}
		return try self.parse(data: data)
	}

	internal static func parse(data: [String: Any]) throws -> SauceNaoResult {
		guard let header = data["header"] as? [String: Any] else {
			throw ResultParseError.missingHeader(header: "header")
		}
		guard let status = Parser.toInt(header["status"]) else {
			throw ResultParseError.missingHeader(header: "status")
		}
		let message = header["message"] as? String
		let limits = try Limits.parse(header: header)
		let account = try? Account.parse(header: header)
		let info = try? ResultsInfo.parse(header: header)
		if let resultsData = data["results"] as? [Any] {
			var results = [Result]()
			for resultData in resultsData {
				if let resultData = resultData as? [String: Any] {
					if let result = try? Result.parse(result: resultData) {
						results.append(result)
					}
				}
			}
			return SauceNaoResult(header: header, status: status, message: message, limits: limits, account: account, info: info, results: results)
		}
		return SauceNaoResult(header: header, status: status, message: message, limits: limits, account: account, info: info, results: nil)
	}
}

public struct Limits {

	// header.long_limit
	public let longLimit: Int
	// header.short_limit
	public let shortLimit: Int
	// header.long_remaining
	public let longRemaining: Int
	// header.short_remaining
	public let shortRemaining: Int

	internal static func parse(header: [String: Any]) throws -> Limits {
		guard let ll = Parser.toInt(header["long_limit"]) else {
			throw ResultParseError.missingHeader(header: "long_limit")
		}
		guard let lr = Parser.toInt(header["long_remaining"]) else {
			throw ResultParseError.missingHeader(header: "long_remaining")
		}
		guard let sl = Parser.toInt(header["short_limit"]) else {
			throw ResultParseError.missingHeader(header: "short_limit")
		}
		guard let sr = Parser.toInt(header["short_remaining"]) else {
			throw ResultParseError.missingHeader(header: "short_remaining")
		}
		return Limits(longLimit: ll, shortLimit: sl, longRemaining: lr, shortRemaining: sr)
	}
}

public struct Account {

	// header.account_type
	public let accountType: Int
	// header.user_id
	public let userId: Int

	internal static func parse(header: [String: Any]) throws -> Account {
		guard let uid = Parser.toInt(header["user_id"]) else {
			throw ResultParseError.missingHeader(header: "user_id")
		}
		guard let at = Parser.toInt(header["account_type"]) else {
			throw ResultParseError.missingHeader(header: "account_type")
		}
		return Account(accountType: at, userId: uid)
	}
}

public struct ResultsInfo {

	// header.results_requested
	public let resultsRequested: Int
	// header.results_returned
	public let resultsReturned: Int
	// header.minimum_similarity
	public let minimumSimilarity: Double
	// header.search_depth
	public let searchDepth: Int

	internal static func parse(header: [String: Any]) throws -> ResultsInfo {
		guard let rrq = Parser.toInt(header["results_requested"]) else {
			throw ResultParseError.missingHeader(header: "results_requested")
		}
		guard let rrt = Parser.toInt(header["results_returned"]) else {
			throw ResultParseError.missingHeader(header: "results_returned")
		}
		guard let ms = Parser.toDouble(header["minimum_similarity"]) else {
			throw ResultParseError.missingHeader(header: "minimum_similarity")
		}
		guard let sd = Parser.toInt(header["search_depth"]) else {
			throw ResultParseError.missingHeader(header: "search_depth")
		}
		return ResultsInfo(resultsRequested: rrq, resultsReturned: rrt, minimumSimilarity: ms, searchDepth: sd)
	}
}

public struct Result {

	// header.index_id
	public let indexId: Int
	// header.index_name
	public let indexName: String
	// header.similarity
	public let similarity: Double
	// header.thumbnail
	public let thumbnail: String

	// data.author_name
	// data.member_name
	// data.creator
	public let authors: [String]?

	// data.source
	public let source: String?
	// data.type
	public let type: String?

	// data.title
	public let title: String?
	// data.eng_name
	public let eng_name: String?
	// data.jp_name
	public let jap_name: String?

	// data.ext_urls
	public let externalUrls: [String]?

	public let data: [String: Any]

	// data.bcy_id
	// data.bcy_type
	// data.member_id
	// data.member_link_id
	// data.danbooru_id
	// data.gelbooru_id
	// data.sankaku_id
	// data.pixiv_id
	// data.yandere_id
	// data.seiga_id
	// data.drawr_id
	// data.nijie_id
	// data.mu_id
	// data.pawoo_id
	// data.pawoo_user_id
	// data.pawoo_user
	// data.pawoo_user_display_name
	// data.material
	// data.part
	// data.date
	// data.characters
	// data.da_id
	// data.author_url

	internal static func parse(result: [String: Any]) throws -> Result {
		guard let header = result["header"] as? [String: Any] else {
			throw ResultParseError.missingHeader(header: "header")
		}
		guard var data = result["data"] as? [String: Any] else {
			throw ResultParseError.missingHeader(header: "data")
		}
		guard let indexId = Parser.toInt(header["index_id"]) else {
			throw ResultParseError.missingHeader(header: "index_id")
		}
		guard let indexName = header["index_name"] as? String else {
			throw ResultParseError.missingHeader(header: "index_name")
		}
		guard let similarity = Parser.toDouble(header["similarity"]) else {
			throw ResultParseError.missingHeader(header: "similarity")
		}
		guard let thumbnail = header["thumbnail"] as? String else {
			throw ResultParseError.missingHeader(header: "thumbnail")
		}
		let urls = data["ext_urls"] as? [String]
		let source = data["source"] as? String
		let type = data["type"] as? String
		let title = data["title"] as? String
		let engname = data["eng_name"] as? String
		let japname = data["jp_name"] as? String
		let authors: [String]? = Parser.toArray(data["member_name"]) ?? Parser.toArray(data["author_name"]) ?? Parser.toArray(data["creator"])
		data.removeValue(forKey: "ext_urls")
		data.removeValue(forKey: "source")
		data.removeValue(forKey: "type")
		data.removeValue(forKey: "title")
		data.removeValue(forKey: "eng_name")
		data.removeValue(forKey: "jp_name")
		if authors != nil && data.removeValue(forKey: "member_name") == nil && data.removeValue(forKey: "author_name") == nil {
			data.removeValue(forKey: "creator")
		}
		return Result(indexId: indexId, indexName: indexName, similarity: similarity, thumbnail: thumbnail, authors: authors, source: source, type: type, title: title, eng_name: engname, jap_name: japname, externalUrls: urls, data: data)
	}
}
