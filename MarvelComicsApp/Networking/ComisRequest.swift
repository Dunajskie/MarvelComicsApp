//
//  ComisRequest.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 24/05/2022.
//

import Foundation

struct ComicsRequest: DataRequest {

    private let apiKey: String = "080a502746c8a60aeab043387a56eef0"
    private let ts: String = "1"
    private let hash: String = "6edc18ab1a954d230c1f03c590d469d2"
    private let limit: String = "25"
    private let offset: String = "0"
    private let orderBy: String = "-onsaleDate"

    var url: String {
        let baseURL: String = "https://gateway.marvel.com"
        let path: String = "/v1/public/comics"
        return baseURL + path
    }

    var queryItems: [String : String] {
        [
            "ts": ts,
            "apikey": apiKey,
            "hash": hash,
            "limit": limit,
            "offset": offset,
            "orderBy": orderBy,
        ]
    }

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> [Comics] {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(APIResponse.self, from: data)
        return response.data.results
    }
}
