//
//  User.swift
//  HW21_Server
//
//  Created by Nata on 24.07.2021.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?
}

// MARK: - Address

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

// MARK: - Company

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

// MARK: - Geo

struct Geo: Codable {
    let lat: String?
    let lng: String?
}

// MARK: - Posts

struct Posts: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

// MARK: - Comments

struct Comments: Codable {
    let postId: Int?
    let id: Int?
    let email: String?
    let name: String?
    let body: String?
}

struct Photos: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}

struct Albums: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
}
