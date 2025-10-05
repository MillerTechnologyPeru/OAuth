//
//  JWT.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation

// MARK: - JWT

public struct JSONWebToken <Header: JWTHeader, Body: JWTPayload> {
    
    public let header: Header
    
    public let body: Body
    
    public let signature: String
}

extension JSONWebToken where Header: Decodable, Body: Decodable {
    
    public init?(rawValue jwt: String) {
        let parts = jwt.components(separatedBy: ".")
        // parse string
        guard parts.count == 3,
              let headerData = Data(base64URLEncoded: parts[0]),
              let bodyData = Data(base64URLEncoded: parts[1]) else {
            return nil
        }
        // decode JSON parts
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            self.header = try decoder.decode(Header.self, from: headerData)
            self.body = try decoder.decode(Body.self, from: bodyData)
        }
        catch {
            return nil
        }
        
        self.signature = parts[2]
    }
}

extension JSONWebToken: Equatable where Header: Equatable, Body: Equatable { }

extension JSONWebToken: Hashable where Header: Hashable, Body: Hashable { }

extension JSONWebToken: Sendable where Header: Sendable, Body: Sendable { }

/// JWT Header
public protocol JWTHeader {
    
    var algorithm: JWTAlgorithm { get }
    
    var type: JWTType? { get }
    
    var keyId: String? { get }
    
    var contentType: String? { get }
}

/// JWT Payload
public protocol JWTPayload: Identifiable {
    
    var id: String? { get }
    
    var issuer: String { get }
    
    var subject: String { get }
    
    var audience: String { get }
    
    var expiration: Date { get }
    
    var notBefore: Date? { get }
    
    var issuedAt: Date { get }
}

// MARK: - Supporting Types

/// Represents a Standard JWT header
public struct JWTStandardHeader: JWTHeader, Equatable, Hashable, Codable, Sendable {
    
    /// Signing algorithm
    public let algorithm: JWTAlgorithm
    
    /// Type of token (usually "JWT")
    public let type: JWTType?
    
    /// Key ID, used to select the correct public key
    public let keyId: String?
    
    /// Content type, optional
    public let contentType: String?
    
    public init(
        algorithm: JWTAlgorithm,
        type: JWTType? = .jwt,
        keyId: String? = nil,
        contentType: String? = nil
    ) {
        self.algorithm = algorithm
        self.type = type
        self.keyId = keyId
        self.contentType = contentType
    }
    
    enum CodingKeys: String, CodingKey {
        case algorithm = "alg"
        case type = "typ"
        case keyId = "kid"
        case contentType = "cty"
    }
}

/// Standard JWT / JWS signing algorithms
public enum JWTAlgorithm: String, Codable, CaseIterable, Sendable {
    
    // HMAC (symmetric)
    case hs256 = "HS256"
    case hs384 = "HS384"
    case hs512 = "HS512"
    
    // RSA (asymmetric)
    case rs256 = "RS256"
    case rs384 = "RS384"
    case rs512 = "RS512"
    
    // RSASSA-PSS (asymmetric)
    case ps256 = "PS256"
    case ps384 = "PS384"
    case ps512 = "PS512"
    
    // ECDSA (asymmetric)
    case es256 = "ES256"
    case es384 = "ES384"
    case es512 = "ES512"
    
    // None (unsigned)
    case none = "none"
}

/// JWT header type
public enum JWTType: String, Codable, CaseIterable, Sendable {
    
    /// JSON Web Token
    case jwt = "JWT"
    
    /// JSON Web Signature
    case jws = "JWS"
    
    /// JSON Web Encryption
    case jwe = "JWE"
    
    /// Generic JOSE object (rare)
    case jose = "JOSE"
}
