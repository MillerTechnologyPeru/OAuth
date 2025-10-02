//
//  Error.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation

public enum OAuthError: Error, Sendable {
    
    case invalidStatusCode(Int)
    case errorResponse(OAuthErrorResponse)
    case invalidResponse(Error?)
}

public extension OAuthError {
    
    static var invalidResponse: OAuthError {
        .invalidResponse(nil)
    }
}
