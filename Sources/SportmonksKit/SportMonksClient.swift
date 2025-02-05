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

    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()

    public init(httpClient: HTTPClient, eventLoop: EventLoop, logger: Logger, apiKey: String) {
        self.httpClient = httpClient
        self.eventLoop = eventLoop
        self.logger = logger
        self.apiKey = apiKey
    }

    public func send<Model: SMModel>(_ apiRequest: ApiRequest) -> EventLoopFuture<Model> {
        do {
            let clientRequest = try HTTPClient.Request(apiRequest)
            return httpClient
                .execute(request: clientRequest, eventLoop: .delegate(on: eventLoop), logger: logger)
                .flatMap { response in
                    guard let byteBuffer = response.body else {
                        fatalError("Response body is missing! This should never happen.")
                    }
                    let responseData = Data(byteBuffer.readableBytesView)

                    do {
                        guard response.status == .ok else {
                            let error = try self.decoder.decode(SMError.self, from: responseData)
                            return self.eventLoop.makeFailedFuture(error)
                        }
                        let decoded = try self.decoder.decode(Model.self, from: responseData)
                        return self.eventLoop.makeSucceededFuture(decoded)
                    } catch {
                        return self.eventLoop.makeFailedFuture(error)
                    }
                }
        } catch {
            return self.eventLoop.makeFailedFuture(error)
        }
    }

    /// Hop to a new eventloop to execute requests on.
    /// - Parameter eventLoop: The eventloop to execute requests on.
    public func hopped(to eventLoop: EventLoop) -> SportMonksClient {
        self.eventLoop = eventLoop
        return self
    }
}
