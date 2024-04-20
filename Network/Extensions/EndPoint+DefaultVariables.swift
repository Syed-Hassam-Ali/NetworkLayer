//
//  EndPoint+DefaultVariables.swift
//  StarzPlay_App
//
//  Created by Hassam Ali on 11/04/2024.
//

import Foundation

public extension Endpoint {

    var baseURL: String {
        NetworkInitializationManager.shared.getBaseURL()
    }

    var encoding: ParameterEncoding {
        .jsonEncoding
    }

    func defaultHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["language"] = "en-US"
        headers["Authorization"] = NetworkInitializationManager.shared.getAPIKey()
        return headers
    }
}
