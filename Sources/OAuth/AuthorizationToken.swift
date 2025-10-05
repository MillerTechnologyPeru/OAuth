//
//  AuthorizationToken.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//


import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import HTTP

/// OAuth Authorization Token
public struct AuthorizationToken<Header: JWTHeader, Payload: JWTPayload> {
    
    public let rawValue: String
    
    internal let jwt: JSONWebToken<Header, Payload>
}

public extension AuthorizationToken {
    
    var header: Header {
        jwt.header
    }
    
    var payload: Payload {
        jwt.body
    }
    
    var signature: String {
        jwt.signature
    }
}

extension AuthorizationToken: Equatable where Header: Equatable, Payload: Equatable { }

extension AuthorizationToken: Hashable where Header: Hashable, Payload: Hashable { }

extension AuthorizationToken: Sendable where Header: Sendable, Payload: Sendable { }

extension AuthorizationToken: RawRepresentable, Codable where Header: Decodable, Payload: Decodable {
    
    public init?(rawValue: String) {
        guard let jwt = JSONWebToken<Header, Payload>(rawValue: rawValue) else {
            return nil
        }
        self.rawValue = rawValue
        self.jwt = jwt
    }
}

// MARK: - CustomStringConvertible

extension AuthorizationToken: CustomStringConvertible {
    
    public var description: String {
        rawValue
    }
}

// MARK: - HTTP Header

extension AuthorizationToken: HTTPHeader {
    
    public static var httpHeaderName: HTTPTypes.HTTPField.Name {
        .authorization
    }
    
    public var httpHeaderValue: String {
        "Bearer " + rawValue
    }
}
