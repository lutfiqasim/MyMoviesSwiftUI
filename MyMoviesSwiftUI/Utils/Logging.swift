//
//  Logging.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import OSLog

extension Logger {
    static let debug = Logger(subsystem: "com.lutfi.MyMoviesSwiftUI", category: "debug")
    
    static func d(_ message: String,  file: String = #fileID, function: String = #function, line: Int = #line) {
        #if DEBUG
            Logger.debug.debug("[\(file):\(line)] \(function) – \(message)")
        #endif
    }
}
