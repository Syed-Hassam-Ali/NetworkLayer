//
//  JSONParameterEncoder.swift
//  StarzPlay_App
//
//  Created by Hassam Ali on 11/04/2024.
//

import Foundation

struct JSONParameterEncoder {
    func encode(request: inout URLRequest, params: [String: Any]) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONSerialization.data(withJSONObject: params,
                                                  options: .prettyPrinted)
            request.httpBody = data
        } catch let error {
            // TODO: Should I throw exception?
        }
    }
}
