//
//  LogEntry.swift
//  DebugOverlayKit
//
//  Created by viltsevdanila on 9/8/25.
//

import Foundation

public struct LogEntry: Identifiable {
    public let id = UUID()
    public let date: Date
    public let message: String
    public let level: LogLevel
}

public enum LogLevel {
    case info, warning, error
}
