//
//  SportMonksClient.swift
//  
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import Foundation
import AsyncHTTPClient
import NIO
import Logging

public final class SportMonksClient {
    
    var eventLoop: EventLoop
    
    private let httpClient: HTTPClient
    private let logger: Logger
    private let apiKey: String
    
    private let decoder = JSONDecoder()
    
    init(httpClient: HTTPClient, eventLoop: EventLoop, logger: Logger, apiKey: String) {
        self.httpClient = httpClient
        self.eventLoop = eventLoop
        self.logger = logger
        self.apiKey = apiKey
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func send<Model: Decodable>(_ apiRequest: ApiRequest) -> EventLoopFuture<Model> {
        do {
            let clientRequest = try HTTPClient.Request(apiRequest)
            return httpClient
                .execute(request: clientRequest, eventLoop: .delegate(on: eventLoop), logger: logger)
                .flatMap { response in
                    guard let byteBuffer = response.body else {
                        fatalError("Response body from Stripe is missing! This should never happen.")
                    }
                    let responseData = Data(byteBuffer.readableBytesView)
                    
                    do {
                        guard response.status == .ok else {
                            return self.eventLoop.makeFailedFuture(try self.decoder.decode(SMError.self, from: responseData))
                        }
                        return self.eventLoop.makeSucceededFuture(try self.decoder.decode(Model.self, from: responseData))
                    } catch {
                        return self.eventLoop.makeFailedFuture(error)
                    }
                }
        } catch {
            return self.eventLoop.makeFailedFuture(error)
        }
    }
}

// TODO:
public final class SMError: Decodable, Error {
}
