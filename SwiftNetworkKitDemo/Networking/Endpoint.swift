//
//  Endpoint.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
}

extension Endpoint {
    var headers: [String: String]? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var body: Encodable? {
        nil
    }
}