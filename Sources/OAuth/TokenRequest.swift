//
//  TokenRequest.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation

/// Represents a generic OAuth 2.0 token request payload
public struct TokenRequest: Equatable, Hashable, Codable, Sendable {
    
    public let clientId: String
    public let clientSecret: String
    public let audience: String?
    public let grantType: GrantType
    public let scope: String?
    
    public init(clientId: String,
                clientSecret: String,
                audience: String? = nil,
                grantType: GrantType,
                scope: String? = nil) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.audience = audience
        self.grantType = grantType
        self.scope = scope
    }
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case audience
        case grantType = "grant_type"
        case scope
    }
}
