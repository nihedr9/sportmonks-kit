//
//  File.swift
//  
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import Foundation
import NIOHTTP1

public enum ApiRequest {
    static let baseUri = "https://soccer.sportmonks.com"
    static let apiPath = "/api"
    static let apiVersion = "/v2.0"

    case leagues(String)

    var method: HTTPMethod {
        switch self {
        case .leagues:
            return .GET
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .leagues:
            return .init()
        }
    }

    var path: String {
        switch self {
        case .leagues:
            return "/leagues"
        }
    }

    var query: String {
        switch self {
        case .leagues(let apiKey):
            return "api_token=\(apiKey)"
        }
    }

    var url: String {
        Self.baseUri + Self.apiPath + Self.apiVersion + path + "?\(query)"
    }
}
