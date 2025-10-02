//
//  GrantType.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

/// OAuth Grant Type
public enum GrantType: String, Codable, CaseIterable, Sendable {
    
    /// Used in the Authorization Code Flow (with user login, optionally PKCE).
    case authorizationCode = "authorization_code"
    
    /// Used in the Implicit Flow (tokens returned directly in URL fragment).
    case implicit = "implicit"
    
    /// Resource Owner Password Credentials Flow — client exchanges username/password for a token.
    case password = "password"
    
    /// Machine-to-machine tokens; client authenticates directly using client ID/secret.
    case clientCredentials = "client_credentials"
    
    /// Exchange a refresh token for a new access token.
    case refreshToken = "refresh_token"
    
    /// Device Authorization Flow (RFC 8628)
    case deviceCode = "urn:ietf:params:oauth:grant-type:device_code"
    
    /// JWT assertion (RFC 7523)
    case jwtBearer = "urn:ietf:params:oauth:grant-type:jwt-bearer"
    
    /// SAML assertion (RFC 7522)
    case saml2Bearer = "urn:ietf:params:oauth:grant-type:saml2-bearer"
    
    /// Token Exchange (RFC 8693)
    case tokenExchange = "urn:ietf:params:oauth:grant-type:token-exchange"
}
