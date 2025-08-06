//
//  EndPoint+DefaultVariables.swift
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

    var parameters: [String: Any] {
        [:]
    }

    var headers: HTTPHeaders {
        [:]
    }

    func defaultHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["language"] = "en-US"
        headers["Authorization"] = NetworkInitializationManager.shared.getAPIKey()
        for (key, value) in DeviceInfo.shared.asDictionary {
            headers[key] = value
        }
        return headers
    }
}
