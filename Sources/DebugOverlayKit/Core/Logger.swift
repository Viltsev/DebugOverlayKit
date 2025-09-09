//
//  Logger.swift
//  DebugOverlayKit
//
//  Created by viltsevdanila on 9/8/25.
//

import Foundation

public class Logger {
    @MainActor public static let shared = Logger()
    public private(set) var logs: [LogEntry] = []

    private init() {}

    public func log(_ message: String, level: LogLevel = .info) {
        let entry = LogEntry(date: Date(), message: message, level: level)
        logs.append(entry)
        NotificationCenter.default.post(name: .loggerDidUpdate, object: nil)
    }
}

extension Notification.Name {
    static let loggerDidUpdate = Notification.Name("loggerDidUpdate")
}
