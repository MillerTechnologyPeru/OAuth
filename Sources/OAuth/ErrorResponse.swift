//
//  ErrorResponse.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation

/// Represents a standard OAuth 2.0 error response.
public struct OAuthErrorResponse: Equatable, Hashable, Codable, Sendable {
    
    /// A single error code (e.g., "invalid_request", "invalid_client")
    public let error: String
    
    /// Human-readable explanation of the error
    public let errorDescription: String?
    
    /// URL pointing to documentation about this error
    public let errorURI: URL?
    
    public enum CodingKeys: String, CodingKey, CaseIterable, Sendable {
        case error
        case errorDescription = "error_description"
        case errorURI = "error_uri"
    }
}
