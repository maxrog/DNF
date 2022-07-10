//
//  DNFLogger.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import UIKit

struct DNFLogger {
    
    static var logLevel: DNFLogLevel  = .verbose
    
    static func log(_ logType: DNFLogType, _ message: String, sender: String, verbose: String? = nil) {
        guard logLevel != .none else { return }
        switch logType {
        case .error:
            debugPrint("📕 Error: \(message) \(sender)")
        case .fatal:
            assertionFailure("📕 FATAL: \(message) \(sender)")
        case .warning:
            debugPrint("📙 Warning: \(message) \(sender)")
        case .success:
            debugPrint("📗 Success: \(message) \(sender)")
        case .action:
            debugPrint("📘 Action: \(message) \(sender)")
        case .canceled:
            debugPrint("📓 Cancelled: \(message) \(sender)")
        }
        if let verbose = verbose, logLevel == .verbose {
            debugPrint("\(sender) \n \(verbose)")
        }
    }
    
}

enum DNFLogType: String {
    case error
    case fatal
    case warning
    case success
    case action
    case canceled
}

enum DNFLogLevel {
    case none, standard, verbose
}
