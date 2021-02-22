//
//  File.swift
//  
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import Foundation

public protocol SMModel: Codable {}

public struct DataResponse<Model: SMModel>: SMModel {
    public let data: [Model]
}

public final class SMError: SMModel, Error {
    struct ErrorContent: Codable {
        let message: String
        let code: Int
    }
    let error: ErrorContent
}
