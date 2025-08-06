//
//  Endpoint+ApiCallMethod.swift
//
//  Created by Hassam Ali on 11/04/2024.
//

import Foundation

public extension Endpoint {
    func call(completion: @escaping ((Result<ResponseType, Error>) -> Void)) {
        guard let request = getRequest() else {
            completion(.failure(getError(for: .couldnotGenerateRequestObject)))
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(getError(for: .errorReturnedByAPI(error: error))))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(getError(for: .noResponseFound)))
                return
            }
            let statusCode = response.statusCode
            guard (200 ..< 300).contains(statusCode) else {
                completion(.failure(getError(for: .statusCodeIsNot200(statusCode))))
                return
            }
            guard let data = data else {
                completion(.failure(getError(for: .noDataFound)))
                return
            }
            do {
                let model = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(.success(model))
                return
            } catch let error {
                completion(.failure(getError(for: .parsingFailed(error: error))))
                return
            }
        }.resume()
    }

    private func getRequest() -> URLRequest? {
        let urlString = self.baseURL + self.pathURL
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        addHeaders(request: &request)
        applyEncoding(request: &request)
        logCurl(request: request as URLRequest)
        return request
    }

    private func addHeaders(request: inout URLRequest) {
        let headers = self.headers
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        for (key, value) in self.defaultHeaders() {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    private func applyEncoding(request: inout URLRequest) {
        self.encoding.applyEncoding(request: &request, params: self.parameters)
    }

    private func getError(for errorType: APIErrorsType) -> Error {
        let error: Error = NSError(domain: "API Failed",
                                   code: errorType.value,
                                   userInfo: ["message": errorType.message])
        return error
    }

    private func logCurl(request: URLRequest) {
        var curlCommand = "curl"

        // Method
        let method = request.httpMethod ?? "GET"
        if method != "GET" {
            curlCommand += " -X \(method)"
        }

        // Headers
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                curlCommand += " -H '\(key): \(value)'"
            }
        }

        // Body
        if let httpBody = request.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8),
           !bodyString.isEmpty {
            curlCommand += " -d '\(bodyString)'"
        }

        // URL
        if let url = request.url?.absoluteString {
            curlCommand += " '\(url)'"
        }

        // Final print
        print("------- cURL Request --------")
        print(curlCommand)
        print("--------- End cURL ----------")
    }

}
