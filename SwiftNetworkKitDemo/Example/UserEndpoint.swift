//
//  UserEndpoint.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

enum UserEndpoint: Endpoint {

    case getUsers
    case getUser(id: Int)
    case createUser(CreateUserRequest)

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUser(let id):
            return "/users/\(id)"
        case .createUser:
            return "/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUser:
            return .GET
        case .createUser:
            return .POST
        }
    }

    var body: Encodable? {
        switch self {
        case .createUser(let request):
            return request
        default:
            return nil
        }
    }

    var headers: [String: String]? {
        [
            "X-App-Version": "1.0.0"
        ]
    }
}