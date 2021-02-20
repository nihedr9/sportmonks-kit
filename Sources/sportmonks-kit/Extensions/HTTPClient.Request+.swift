//
//  HTTPClient.swift
//  
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import AsyncHTTPClient

extension HTTPClient.Request {

    init(_ request: ApiRequest) throws {
        try self.init(url: request.url, method: request.method, headers: request.headers, body: nil)
    }
}
