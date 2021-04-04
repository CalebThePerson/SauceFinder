//
//  Limiter.swift
//  Swift-SauceNao
//
//  Created by Jaquet Vincent on 14.02.19.
//  Copyright © 2019 Vinrobot. All rights reserved.
//

import Foundation

enum LimiterError: Error {
	case rateLimited
}

public final class Limiter {

	public static let longLimiter = Limiter(count: 300, time: 86400)
	public static let shortLimiter = Limiter(count: 12, time: 30)

	public let countLimit: UInt
	public let timeLimit: TimeInterval

	public private(set) var count: UInt = 0

	private let syncQueue = DispatchQueue(label: "net.vinrobot.ratelimiter", attributes: [])
	private var timer: Timer?

	public init(count: UInt, time: TimeInterval) {
		self.countLimit = count
		self.timeLimit = time
	}

	deinit {
		self.timer?.invalidate()
	}

	@discardableResult
	public func execute<T>(_ block: () -> T) throws -> T {
		let canExecute = self.canExecute()
		guard canExecute else {
			throw LimiterError.rateLimited
		}
		return block()
	}

	public func canExecute() -> Bool {
		return syncQueue.sync { () -> Bool in
			if self.timer == nil {
				self.timer = Timer.scheduledTimer(timeInterval: self.timeLimit, target: self, selector: #selector(reset), userInfo: nil, repeats: true)
			}
			if count < countLimit {
				count += 1
				return true
			}
			return false
		}
	}

	public func cancelExecute() {
		syncQueue.sync {
			if self.count > 0 {
				self.count -= 1
			}
		}
	}

	public func setCount(_ count: UInt) {
		syncQueue.sync {
			self.count = count
		}
	}

	@objc
	public func reset() {
		syncQueue.sync {
			self.count = 0
		}
	}
}
