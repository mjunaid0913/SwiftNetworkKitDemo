//
//  NetworkError.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noInternet
    case timeout
    case invalidResponse
    case decodingFailed
    case unauthorized
    case forbidden
    case notFound
    case serverError(Int)
    case sslPinningFailed
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .noInternet:
            return "No internet connection."
        case .timeout:
            return "Request timed out."
        case .invalidResponse:
            return "Invalid server response."
        case .decodingFailed:
            return "Failed to decode response."
        case .unauthorized:
            return "Unauthorized request."
        case .forbidden:
            return "Access forbidden."
        case .notFound:
            return "Resource not found."
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .sslPinningFailed:
            return "SSL pinning validation failed."
        case .custom(let message):
            return message
        }
    }
}