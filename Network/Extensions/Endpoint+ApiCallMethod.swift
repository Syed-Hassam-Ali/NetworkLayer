//
//  Endpoint+ApiCallMethod.swift
//  StarzPlay_App
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
            guard let response = response as? HTTPURLResponse,
                  (200 ..< 300).contains(response.statusCode) else {
                completion(.failure(getError(for: .statusCodeIsNot200)))
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
    }

    private func applyEncoding(request: inout URLRequest) {
        
    }

    private func getError(for errorType: APIErrorsType) -> Error {
        let error: Error = NSError(domain: "API Failed",
                                   code: errorType.value,
                                   userInfo: ["message": errorType.message])
        return error
    }

    private func logCurl(request: URLRequest) {
        // TODO: - Update printing curl
        debugPrint("------- Curl Print -----------")
        debugPrint(request.debugDescription)
        debugPrint("--------- Curl End -----------")
    }

}
