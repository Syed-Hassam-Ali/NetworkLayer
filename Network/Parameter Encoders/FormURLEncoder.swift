//
//  FormURLEncoder.swift
//  NetworkLayerTesting
//
//  Created by Hassam on 06/08/2025.
//

import Foundation

public struct FormURLEncoder {
    func encode(request: inout URLRequest, params: [String: Any]) {
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let bodyString = params.map { "\($0.key)=\($0.value)" }
                               .joined(separator: "&")
                               .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        request.httpBody = bodyString?.data(using: .utf8)
    }
}
