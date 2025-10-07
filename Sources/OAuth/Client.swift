//
//  Client.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import HTTP

public extension URLClient {
    
    func oauthToken<Header, Payload>(
        _ request: TokenRequest,
        url: URL,
        formEncoded: Bool = false
    ) async throws -> TokenResponse<Header, Payload> where Header: Decodable, Payload: Decodable {
        let urlRequest: URLRequest
        if formEncoded {
            urlRequest = .init(url: url, formURLEncoded: request)
        } else {
            urlRequest = try .init(url: url, json: request)
        }
        var statusCode = 200
        let (data, urlResponse) = try await self.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            assertionFailure("Invalid response type \(urlResponse)")
            throw Foundation.URLError(.unknown)
        }
        let decoder = JSONDecoder.oauth
        let expectedStatusCode = statusCode
        statusCode = httpResponse.statusCode
        guard statusCode == expectedStatusCode else {
            if data.isEmpty == false, let decodedResponse = try? decoder.decode(OAuthErrorResponse.self, from: data) {
                throw OAuthError.errorResponse(decodedResponse)
            } else {
                throw OAuthError.invalidStatusCode(httpResponse.statusCode)
            }
        }
        do {
            return try decoder.decode(TokenResponse.self, from: data)
        } catch {
            throw OAuthError.invalidResponse(error)
        }
    }
}

internal extension URLRequest {
    
    init(
        url: URL,
        formURLEncoded request: TokenRequest,
    ) {
        self.init(url: url)
        self.httpMethod = HTTPMethod.post.rawValue
        self.setFormURLEncoded(request.formItems)
    }
    
    init(
        url: URL,
        json request: TokenRequest,
    ) throws {
        self.init(url: url)
        self.httpMethod = HTTPMethod.post.rawValue
        self.httpBody = try JSONEncoder.oauth.encode(request)
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

internal extension TokenRequest {
    
    var formItems: [URLQueryItem] {
        [
            .init(name: TokenRequest.CodingKeys.clientId.rawValue, value: clientId),
            .init(name: TokenRequest.CodingKeys.clientSecret.rawValue, value: clientSecret),
            .init(name: TokenRequest.CodingKeys.grantType.rawValue, value: grantType.rawValue),
            scope.flatMap { .init(name: TokenRequest.CodingKeys.scope.rawValue, value: $0) }
        ].compactMap({ $0 })
    }
}
