//
//  TokenResponse.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

public struct TokenResponse <Header, Payload> {
    
    public let tokenType: TokenType
    public let scope: String?
    public let expiresIn: Int
    public let extExpiresIn: Int?
    public let accessToken: AuthorizationToken<Header, Payload>
    public let refreshToken: AuthorizationToken<Header, Payload>?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case scope
        case expiresIn = "expires_in"
        case extExpiresIn = "ext_expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

extension TokenResponse: Equatable where Header: Equatable, Payload: Equatable { }

extension TokenResponse: Hashable where Header: Hashable, Payload: Hashable { }

extension TokenResponse: Sendable where Header: Sendable, Payload: Sendable { }

extension TokenResponse: Codable where Header: Decodable, Payload: Decodable { }
