//
//  Model.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 24/05/2022.
//

import Foundation

import Foundation

struct APIResponse: Equatable, Codable {
    let data: ComicsData
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct ComicsData: Equatable, Codable {
    let results: [Comics]
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Comics: Equatable, Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    let creators: Creators

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case thumbnail = "thumbnail"
        case creators = "creators"
    }
}

struct Thumbnail: Equatable, Codable {
    var url: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case url = "path"
        case type = "extension"
    }
}

struct Creators: Equatable, Codable {
    let available: Int
    let persons: [Person]?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case persons = "items"
    }
}

struct Person: Equatable, Codable {
    let name: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case role = "role"
    }
}

