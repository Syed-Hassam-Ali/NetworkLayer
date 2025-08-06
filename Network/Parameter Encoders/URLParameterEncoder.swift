//
//  URLParameterEncoder.swift
//  NetworkLayerTesting
//
//  Created by Hassam on 06/08/2025.
//

import Foundation

public struct URLParameterEncoder {
    func encode(request: inout URLRequest, params: [String: Any]) {
        guard var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) else {
            return
        }

        urlComponents.queryItems = params.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }

        request.url = urlComponents.url
    }
}

