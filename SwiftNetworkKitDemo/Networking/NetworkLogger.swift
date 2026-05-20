//
//  NetworkLogger.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

enum NetworkLogger {
    static var isEnabled = true

    static func log(request: URLRequest) {
        guard isEnabled else { return }

        print("\n========== API REQUEST ==========")
        print("URL:", request.url?.absoluteString ?? "")
        print("METHOD:", request.httpMethod ?? "")

        if let headers = request.allHTTPHeaderFields {
            print("HEADERS:", headers)
        }

        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("BODY:", bodyString)
        }

        print("=================================\n")
    }

    static func log(data: Data, response: HTTPURLResponse) {
        guard isEnabled else { return }

        print("\n========== API RESPONSE ==========")
        print("STATUS CODE:", response.statusCode)

        if let responseString = String(data: data, encoding: .utf8) {
            print("RESPONSE:", responseString)
        }

        print("==================================\n")
    }
}