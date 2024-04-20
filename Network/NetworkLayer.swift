//
//  NetworkLayer.swift
//  StarzPlay_App
//
//  Created by Hassam Ali on 10/04/2024.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
}

public enum ParameterEncoding {
    case jsonEncoding

    func applyEncoding(request: inout URLRequest,
                       params: [String: Any]) {
        switch self {
        case .jsonEncoding:
            JSONParameterEncoder().encode(request: &request,
                                          params: params)
        }
    }
}

public typealias HTTPHeaders = [String: String]

public protocol Endpoint {
    associatedtype ResponseType: Codable
    var pathURL: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: [String: Any] { get }
    var baseURL: String { get }
    var encoding: ParameterEncoding { get }
}

