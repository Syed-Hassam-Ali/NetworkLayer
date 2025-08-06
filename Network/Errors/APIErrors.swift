//
//  APIErrors.swift
//
//  Created by Hassam Ali on 11/04/2024.
//

import Foundation

public enum APIErrorsType {
    case statusCodeIsNot200(Int)
    case noDataFound
    case errorReturnedByAPI(error: Error?)
    case parsingFailed(error: Error?)
    case couldnotGenerateRequestObject
    case noResponseFound
    
    var value: Int {
        switch self {
        case .statusCodeIsNot200:
            return 100
        case .noDataFound:
            return 101
        case .errorReturnedByAPI(_ ):
            return 102
        case .parsingFailed(_ ):
            return 103
        case .couldnotGenerateRequestObject:
            return 104
        case .noResponseFound:
            return 105
        }
    }
    
    var message: String {
        switch self {
        case .statusCodeIsNot200(let statusCode):
            return "Status Code is not between 200 ... 299. Status Code: \(statusCode)"
        case .noDataFound:
            return "API didn't send the data"
        case .errorReturnedByAPI(let error):
            let errorDesc = String(describing: error?.localizedDescription)
            return "API returns error object, with description: \(errorDesc)"
        case .parsingFailed(let error):
            let errorDesc = String(describing: error?.localizedDescription)
            return "API Data Couldn't parse in model, with description: \(errorDesc)"
        case .couldnotGenerateRequestObject:
            return "Failed to generate URLRequest"
        case .noResponseFound:
            return "No response from API"
        }
    }
}
