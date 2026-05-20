//
//  User.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

struct CreateUserRequest: Encodable {
    let name: String
    let email: String
}