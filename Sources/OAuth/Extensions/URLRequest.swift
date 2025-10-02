//
//  URLRequest.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import HTTP

internal extension URLRequest {
    
    mutating func setFormURLEncoded(_ queryItems: [URLQueryItem]) {
        let data = queryItems.formURLEncoded()
        let contentLength = data.count
        self.httpBody = data
        self.setValue(String(contentLength), forHTTPHeaderField: "Content-Length")
        self.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
}

internal extension URLClient {
    
    @discardableResult
    func request(
        _ urlRequest: URLRequest,
        decoder: JSONDecoder = .oauth,
        statusCode: inout Int
    ) async throws -> Data {
        let (data, urlResponse) = try await self.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            assertionFailure("Invalid response type \(urlResponse)")
            throw Foundation.URLError(.unknown)
        }
        let expectedStatusCode = statusCode
        statusCode = httpResponse.statusCode
        guard statusCode == expectedStatusCode else {
            if data.isEmpty == false, let decodedResponse = try? decoder.decode(OAuthErrorResponse.self, from: data) {
                throw OAuthError.errorResponse(decodedResponse)
            } else {
                throw OAuthError.invalidStatusCode(httpResponse.statusCode)
            }
        }
        return data
    }
}
