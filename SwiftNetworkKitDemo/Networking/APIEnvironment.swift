//
//  APIEnvironment.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

enum APIEnvironment {
    case development
    case staging
    case qa
    case production

    var baseURL: String {
        switch self {
        case .development:
            return "https://dev.api.example.com"
        case .staging:
            return "https://staging.api.example.com"
        case .qa:
            return "https://qa.api.example.com"
        case .production:
            return "https://api.example.com"
        }
    }

    var enableLogs: Bool {
        switch self {
        case .production:
            return false
        default:
            return true
        }
    }

    var sslPinningEnabled: Bool {
        switch self {
        case .production:
            return true
        default:
            return false
        }
    }
}
